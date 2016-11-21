shared_examples '#persisted?' do
  it 'returns false when there is no id' do
    expect(form.persisted?).to be false
  end

  it 'returns true when id is present' do
    attributes[:id] = 1
    expect(form.persisted?).to be true
  end
end
