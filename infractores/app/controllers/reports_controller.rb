class ReportsController < ApplicationController
  before_filter :load_report, only: [:show]
  before_filter :load_images, only: [:show]

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.valid_reports
    @hash = Gmaps4rails.build_markers(@reports) do |report, marker|
      marker.lat report.latitude
      marker.lng report.longitude
      marker.infowindow report.post
    end
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @hash = Gmaps4rails.build_markers(@report) do |report, marker|
      marker.lat report.latitude
      marker.lng report.longitude
      marker.infowindow report.post
    end
  end

  private

    def load_report
      @report = Report.find(params[:id])
    end

    def load_images
      @images = @report.images
    end
end
