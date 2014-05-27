class MaterialsController < ApplicationController
  before_action :require_user, only: :index
  before_action :require_admin, except: :index
  before_action :set_material, only: [:edit, :update, :destroy]

  # GET /materials
  def index
    pg_result = Material.connection.execute <<-SQL
      SELECT s.code as subject_code, m.name as material_name, m.original_name, r.quantity
      FROM requisitions r
      INNER JOIN materials m ON m.id = r.material_id
      INNER JOIN exercises e ON e.id = r.exercise_id
      INNER JOIN topics t ON t.id = e.topic_id
      INNER JOIN subjects s ON s.id = t.subject_id
      WHERE m.archived = false
      ORDER BY m.name, m.original_name;
    SQL

    @subject_codes = []
    @quantities_by_subject_code_by_material_name = pg_result.values.each_with_object({}) do |result, hash|
      subject_code  = result.first
      material_name = result.second || result.third
      quantity      = result.last.nil? ? nil : result.last.to_i

      @subject_codes << subject_code

      hash[material_name] ||= {}
      hash[material_name][subject_code] ||= []
      hash[material_name][subject_code] << quantity
    end

    @subject_codes.uniq!
  end

  # GET /materials/manage
  def manage
    @materials = Material.order("archived DESC, original_name")
  end

  # GET /materials/new
  def new
    @material = Material.new
  end

  # GET /materials/1/edit
  def edit
  end

  # POST /materials
  def create
    @material = Material.new(material_params)

    if @material.save
      redirect_to edit_material_path(@material), notice: 'Material was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /materials/1
  def update
    if @material.update(material_params)
      if params[:exercise_id]
        exercise = Exercise.find( params[:exercise_id] )
        redirect_to canonical_topic_path(exercise.topic.slug, anchor: "part-#{exercise.part}", material_id: @material.id), notice: 'Material was sucessfully updated.'
      else
        redirect_to edit_material_path(@material), notice: 'Material was successfully updated.'
      end
    else
      render action: 'edit'
    end
  end

  # DELETE /materials/1
  def destroy
    @material.archive
    redirect_to materials_url, notice: 'Material was successfully archived.'
  end

  def merge
    winner       = Material.find(params[:winner_id])
    losers       = Material.where(id: params[:loser_ids].split(","))
    links        = []
    exercise_ids = []


    losers.each do |loser|
      loser.exercises.each do |exercise|
        Requisition.find_or_create_by! exercise_id: exercise.id, material_id: winner.id
        href = canonical_topic_path exercise.topic.slug, anchor: "part-#{exercise.part}"
        links << %Q{<a href="#{href}" target="_blank">#{exercise.id}</a>}
        exercise_ids << exercise.id
      end

      loser.archive
    end

    flash[:notice] = "Exercise(s) #{links.to_sentence} are now associated to this material."

    redirect_to edit_material_path(winner, exercise_ids: exercise_ids)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      @material = Material.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def material_params
      params.require(:material).permit(:name, :description, :url, :archived)
    end
end
