class ProprietesController < ApplicationController
  def index
    @proprietes = Propriete.all
  end
end
