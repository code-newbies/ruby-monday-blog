require "rails_helper"

describe PostsController do
  let!(:author) { create(:author) }

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
    sign_in author

    expect { post :create, params }
      .to change{ Tag.count }.by (1)
  end

  it "can reuse a tag that already exists" do
    sign_in author

    # Create a new tag
    post :create, params

    expect { post :create, params }
      .to_not change{ Tag.count }
  end

  it "assigns current user as post's author" do
    sign_in author

    post :create, params

    expect(Post.last.author).to eq author
  end

  it 'redirects the user from posts#new to posts#index if not logged in' do
    get :new
    expect(response).to redirect_to posts_path
  end

  it 'renders posts#new for a logged in user' do
    sign_in author
    get :new
    expect(request.path).to match new_post_path
  end
end
