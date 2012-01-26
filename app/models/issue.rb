class Issue
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :title, :notes, :labels, :submitted_by

  validates_presence_of :title

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def save
    client = Octokit::Client.new(login: "barbergeek", password: "K33p0ut!")
    issue = client.create_issue("barbergeek/contrac", title, notes )
    client.add_labels_to_an_issue("barbergeek/contrac", issue.number, [labels])
  end

end