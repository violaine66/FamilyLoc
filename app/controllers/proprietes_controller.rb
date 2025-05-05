class ProprietesController < ApplicationController
  def index
    @proprietes = Proprietes.all
  end
end
