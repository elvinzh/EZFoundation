import sys
import os


def run():
    version = get_version()
    print('current version',version)
    if version is not None:
        question = 'will u want to upgrade current pod to \'' + version + '\' ? (y/n)\n'
        choice = input(question).lower()
        if choice == 'y' or choice == 'yes':
            update(version)

def update(version):

    if update_pod_spec(version) == False:
        return

    git_add         = 'git add .'
    git_commit      = 'git commit . -m " pod version update to ' + version + '"'
    git_push        = 'git push'
    git_add_tag     = 'git tag ' + version
    git_push_tag    = 'git push --tags'
    pod_push        = 'pod repo push onepiece NTESFoundation.podspec'

    command_list = [git_add,git_commit,git_push,git_add_tag,git_push_tag,pod_push]
    for command in command_list:
        run_shell(command)

    
def update_pod_spec(version):
    new_source_version_prefix  = 's.version = \''
    new_source_version_suffix  = '\''
    pod_file = './NTESFoundation.podspec'
    new_content = None
    with open(pod_file) as podspec:
            content = podspec.read()
            begin = content.find(new_source_version_prefix) + len(new_source_version_prefix)
            end = content.find(new_source_version_suffix,begin)
            old_version = content[begin:end]
            new_content = content.replace(old_version,version,1)
    if new_content is not None:
        with open(pod_file,'w') as podspec:
            podspec.write(new_content)
            return True
    return False

    

def run_shell(command):
    os.system(command)


def get_version():
    version = None
    if len(sys.argv) == 2:
        candidate_version = sys.argv[1].strip()
        if is_valid_version(candidate_version):
            version = candidate_version
    else:
        print('version needed')
    return version

def is_valid_version(version):
    valid = False
    components = version.split('.')
    if len(components) >= 3:
        for component in components:
            try:
                num = int(component)
            except:
                print('invalid version: ',version)
                return False
        valid = True
    if valid is False:
        print('invalid version: ',version)
    return valid

if __name__ == '__main__':
    run()