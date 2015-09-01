class ReportsController < ApplicationController
  before_action :set_report, only: [:show]

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.valid_reports
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end
end
