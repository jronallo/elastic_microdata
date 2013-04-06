module ApplicationHelper

  def coderay(text)
    CodeRay.scan(text, :json).div #(:css => :class)  
  end

end
