class ApplicationForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def persisted?
    false
  end

  attr_reader :resource

  def initialize(resource)
    @resource = resource
  end
end