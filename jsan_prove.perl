{
	name => 'JSAN::Prove',
	
	title => 'Test suite title',
	
	'Model::Tests' => {
		t_dir => '/home/catalyst/Workspace/EclipseWorkspace/JSAN/test-run/harness'
	},
	
	
	'Model::Browsers' => {
		browsers => 'JSAN::Prove::App::Browser::FireFox'
	}
	
}
