class Api::V1::PerformanceDataController < ApplicationController
    def create
        data = PerformanceData.new(params[:performance_data])
        if data.save
          head :ok
        end
      end
    end
