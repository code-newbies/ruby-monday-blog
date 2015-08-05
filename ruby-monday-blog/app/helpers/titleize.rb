module Titleize
  def prepared_params
    titleize_tags(post_params)
  end

  def titleize(str)
    str.gsub(/\w+/) { |word| word.capitalize }
  end

  def titleize_tags(params)
    return params unless params[:tags_attributes]

    params[:tags_attributes].each do |_, tag|
      tag[:content] = titleize(tag[:content])
    end

    params
  end
end
