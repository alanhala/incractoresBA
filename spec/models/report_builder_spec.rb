require 'rails_helper'
require 'rake'

describe "#create_reports" do
  before do
    @user = double("Twitter::User")
    @tweet = double("Twitter::Tweet")
    allow(@user).to receive_messages(id: 2, screen_name: "example")
    allow_any_instance_of(TweetAdapter).to receive_messages(id: 1, latitude: 2,
                                                              longitude: 3,
                                                              post: "SARASA",
                                                              valid?: true, user: @user)

    allow_any_instance_of(Report).to receive(:attach_images)

  end

  it "should create a valid report for the valid tweet" do
    expect(Report.count).to eq(0)
    ReportBuilder.create_reports([@tweet], "mention")
    expect(Report.count).to eq(1)
    report = Report.first
    expect(report.latitude).to eq(2)
    expect(report.longitude).to eq(3)
    expect(report.post).to eq("SARASA")
    expect(report.is_valid).to be_truthy
  end

  it "should create two valid reports for the same user" do
    ReportBuilder.create_reports([@tweet], "mention")
    allow_any_instance_of(TweetAdapter).to receive(:id).and_return(2)
    ReportBuilder.create_reports([@tweet], "mention")
    expect(Report.valid_reports.count).to eq(2)
    expect(User.count).to eq(1)
    expect(User.last.reports.count).to eq(2)
  end

  it "should not create an user if the tweet is not valid but creates an invalid report" do
    allow_any_instance_of(TweetAdapter).to receive(:valid?).and_return(false)
    ReportBuilder.create_reports([@tweet], "mention")
    expect(Report.valid_reports.count).to eq(0)
    expect(Report.count).to eq(1)
    expect(User.count).to eq(0)
  end
end
