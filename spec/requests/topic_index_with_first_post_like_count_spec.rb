# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Topic index with first post like count" do
  let!(:first_topic) { Fabricate(:topic) }
  let!(:second_topic) { Fabricate(:topic) }

  before do
      Fabricate(:post, topic: first_topic, like_count: 7)
      Fabricate(:post, topic: first_topic, like_count: 5)

      Fabricate(:post, topic: second_topic, like_count: 2)
      Fabricate(:post, topic: second_topic, like_count: 8)
  end

  subject(:get_topics) do
    get "/latest.json"
  end

  it "each topic includes the like count of the first post" do
    get_topics

    parsed_body = JSON.parse(response.body)
    expect(parsed_body["topic_list"]["topics"]).to(
      contain_exactly(
        a_hash_including("first_post_like_count" => 7),
        a_hash_including("first_post_like_count" => 2)
      )
    )
  end
end
