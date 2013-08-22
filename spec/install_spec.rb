require 'chefspec'

describe 'hadupils::default' do
  let (:recipe) { 'hadupils::install' }

  context 'attributes' do
    let (:attrs) { ChefSpec::ChefRunner.new.converge(recipe).node['hadupils']['installs'] }

    it 'should see gem install activated by default' do
      attrs['gem'].should be_true
    end

    it 'should see chef_gem install deactivated by default' do
      attrs['chef_gem'].should be_false
    end
  end

  context 'packages' do
    let (:chef_run) { ChefSpec::ChefRunner.new {|n| n.set['hadupils'] = {'installs' => {}} } }

    context 'with system gem install activated' do
      before do
        chef_run.node.set['hadupils']['installs']['gem'] = true
      end

      it 'should install the hadupils gem' do
        chef_run.converge(recipe)
        chef_run.should install_gem_package 'hadupils'
      end
    end

    context 'with system gem install deactivated' do
      before do
        chef_run.node.set['hadupils']['installs']['gem'] = false
      end

      it 'should not install the hadupils gem' do
        chef_run.converge(recipe)
        chef_run.should_not install_gem_package 'hadupils'
      end
    end

    context 'with chef gem install activated' do
      before do
        chef_run.node.set['hadupils']['installs']['chef_gem'] = true
      end

      it 'should install hadupils with chef_gem' do
        chef_run.converge(recipe)
        chef_run.should install_chef_gem 'hadupils'
      end
    end

    context 'with chef gem install deactivated' do
      before do
        chef_run.node.set['hadupils']['installs']['chef_gem'] = false
      end

      it 'should not install hadupils via chef_gem' do
        chef_run.converge(recipe)
        chef_run.should_not install_chef_gem 'hadupils'
      end
    end
  end
end
