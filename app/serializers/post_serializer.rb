class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at

  has_many :albums
  class AlbumSerializer < ActiveModel::Serializer
    attributes :id, :photo
  end

  def as_json(_opts = {})
   {
     id: id,
     title: title,
     body: body,
     errors: errors,
     album_photos: albums.map do |x|
       {
         url: x.photo.url.absolute_url,
         name: x.photo_file_name,
         id: x.id
       }
     end
   }
 end




  belongs_to :user, key: :author
    class UserSerializer < ActiveModel::Serializer
      attributes(
        :id, :first_name, :last_name,
        :full_name, :created_at, :updated_at
      )
    end

    # has_many :answers will all associated in the serialization
    # of the question model
    has_many :answers

    # To customize the json of associated models, you
    # create the serializer for that model inside then
    # specify the attributes you want.
    class AnswerSerializer < ActiveModel::Serializer
      attributes :id, :body, :created_at, :updated_at, :author_full_name

      def author_full_name
        # To get the model instance that's being serialized,
        # use `object` instead of `self`.
        object.user&.full_name
      end
    end






  end