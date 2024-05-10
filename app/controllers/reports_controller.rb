class ReportsController < ApplicationController
  before_action :authenticate_admin

  def download
    @orders = Order.where(created_at: params[:start_date].to_date..params[:end_date].to_date)

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'orders_report',
               template: 'orders/report',
               layout: 'pdf',
               locals: { orders: @orders }
      end
    end
  end

  private

  def report_params
    params.permit(:start_date, :end_date)
  end
end
