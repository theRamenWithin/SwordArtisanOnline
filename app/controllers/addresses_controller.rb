class AddressesController < ApplicationController
    before_action :set_address, only: [:show, :edit, :update, :destroy]

    def index
        @addresses = Address.all
    end

    def new
        @address = Address.new
    end

    private

    def set_address
      @address = Address.find(params[:id])
    end
end
