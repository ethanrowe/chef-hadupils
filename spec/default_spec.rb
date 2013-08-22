require 'chefspec'

describe 'hadupils::default' do
  let(:recipe) { 'hadupils::default' }

  it 'should include the hadupils::install recipe' do
    chef_run = ChefSpec::ChefRunner.new
    chef_run.converge(recipe)
    expect(chef_run).to include_recipe 'hadupils::install'
  end
end
