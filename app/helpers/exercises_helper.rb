module ExercisesHelper

  def pluralize_ending_for( str )
    return if str.nil?
    last_word = str.split(' ').last
    if last_word.to_s.pluralize.length > last_word.to_s.length
      last_word.pluralize[(( last_word.pluralize.length - last_word.length )*-1)..-1]
    end
  end

end
