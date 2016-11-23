shared_examples '#self.model_name' do
  it 'returns proper model name' do
    expect(described_class.model_name.name).to eq model_name
  end
end

shared_examples '#persisted?' do
  context 'when id is absent' do
    it { is_expected.not_to be_persisted }
  end

  context 'when id is present' do
    let(:id) { 1 }

    it { is_expected.to be_persisted }
  end
end
