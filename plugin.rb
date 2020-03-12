# name: Discourse Topic First Reply
# about: Add `first_reply` field to Topics list serializer
# version: 0.1
# authors: lingokids
# url: https://github.com/lingokids

enabled_site_setting :discourse_first_post_like_count

PLUGIN_NAME ||= "DiscourseFistPostLikeCount".freeze

after_initialize do
  add_to_serializer :topic_list_item, :first_post_like_count do
    object.first_post.like_count
  end
end
