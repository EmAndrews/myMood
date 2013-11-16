require 'logger'

class AndreController < ApplicationController

#logger = Logger.new('log/andre.txt')

  def index
    Rails.logger.debug('Hi Andre')
  
    

  end

end
