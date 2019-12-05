require 'serverspec'
require 'docker-api'

describe 'Dockerfile' do
    before(:all) do
        image = Docker::Image.build_from_dir('.')
        set :backend, :docker
        set :docker_image, image.id
        image
    end

    it 'has kubectl' do
        expect(kubectl_version).to include('v1.16.0')
    end

    it 'has helm2' do
        expect(helm_2_version).to include('2.16.1')
    end

    it 'has helm' do
        expect(helm_3_version).to include('3.0.0')
    end

    it 'has doctl' do
        expect(doctl_version).to include('1.32.3')
    end

    it 'has skaffold' do
        expect(skaffold_version).to include('0.40.0')
    end

    def kubectl_version
        command('kubectl version').stdout
    end

    def helm_2_version
        command('helm2 version').stdout
    end

    def helm_3_version
        command('helm version').stdout
    end

    def doctl_version
        command('doctl version').stdout
    end

    def skaffold_version
        command('skaffold version').stdout
    end
end
