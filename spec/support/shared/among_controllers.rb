shared_examples 'template rendering and http success returning' do |template|
  it 'returns http success' do
    expect(response).to have_http_status(:success)
  end

  it { is_expected.to render_template template }
end

shared_examples 'redirecting user to admin sign in page' do
  it { is_expected.to redirect_to new_user_session_path }

  it 'flashes info' do
    subject
    expect(flash[:notice]).to eq('To access this page you must be logged as an admin.')
  end
end
