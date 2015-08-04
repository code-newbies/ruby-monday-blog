require "rails_helper"

describe PostsController do
  let(:params) do
  {
    post: {
      body:  'lorem',
      title: 'ipsum',
      tags_attributes: {"0" => { content: 'Ruby' }}
    }
  }
  end

  it "creates a new tag if it doesn't exist" do
    expect { post :create, params }
      .to change{ Tag.count }.by (1)
  end

  it "can reuse a tag that already exists" do
    # Create the first tag
    post :create, params

    expect { post :create, params }
      .to_not change{ Tag.count }
  end
end
