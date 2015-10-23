class Api::BenchesController < ApplicationController
  def index
    @benches = Bench.filter(params[:filters])
  end

  def create
    @bench = Bench.new(bench_params)

    if (@bench.save)
      render json: @bench
    end
  end

  private

  def bench_params
    params.require(:bench).permit(:lat, :long, :description, :seating)
  end
end
