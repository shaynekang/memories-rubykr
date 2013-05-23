Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '452779211474184', '92770ce93411bbe71c127b8a467c94c5', {scope: 'publish_stream'}
end