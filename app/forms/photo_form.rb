class PhotoForm < ApplicationForm
  ATTRIBUTES = [:image, :comment, :tag_list]

  ATTRIBUTES.each do |attribute|
    attr_accessor attribute
  end

  def initialize(resource)
    super

    ATTRIBUTES.each do |attribute|
      self.send("#{attribute}=", resource.send(attribute))
    end
  end

  def save!(params)
    tag_list = params.delete("tag_list")

    @photo = resource
    @photo.attributes = params
    @photo.save!

    @photo.tags.clear
    tags = tag_list.split(",").map{|tag| tag.strip}
    tags.each do |tag|
      resource = Tag.find_or_create_by_name(tag)
      @photo.tags << resource unless @photo.tags.exists?(resource)
    end

    @graph = Koala::Facebook::API.new(@photo.owner.token)
    @graph.put_picture("public/#{@photo.image.url}", {"message" => "#{@photo.comment}"})
  end

  def method
    resource.new_record? ? "POST" : "PUT"
  end
end