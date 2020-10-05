import os

def pytest_addoption(parser):
    parser.addoption("--all", action="store_true", help="run all notebooks")


def pytest_generate_tests(metafunc):
    if "notebook_to_test" in metafunc.fixturenames:
        if metafunc.config.getoption("all"):
            nb_list = get_all_notebooks()
        else:
            nb_list = ['01-get-loci-feature-info.ipynb', '05-04-AusPIX_DGGS_Web_API.ipynb']
        metafunc.parametrize("notebook_to_test", nb_list)

def get_all_notebooks():
    extensions = ('.ipynb')
    notebook_list = []
    files = [f for f in os.listdir('.') if os.path.isfile(f)]
    for f in files:
       if f.endswith(extensions):
          notebook_list.append(f)
    return notebook_list
