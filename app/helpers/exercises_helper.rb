module ExercisesHelper

  def pluralize_ending_for( str )
    last_word = str.split(' ').last
    if last_word.pluralize.length > last_word.length
      last_word.pluralize[(( last_word.pluralize.length - last_word.length )*-1)..-1]
    end
  end

end
