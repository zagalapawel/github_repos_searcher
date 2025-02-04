# github_repos_searcher

## Requirements
- Flutter
- Dart SDK included in Flutter
- [FVM](https://fvm.app/)
- [Melos](https://pub.dev/packages/melos)

## How to build app on local environment

### First step
Use [FVM](https://fvm.app/) in this project, make sure you have it installed.
Run command `fvm use 3.27.1` in root project directory.

### Second step
Use [Melos](https://pub.dev/packages/melos) in this project to make commands user friendly.

Run:
- `chmod +x *.sh` in terminal
- `melos run` in terminal
- select `rebuild all` and run it for all packages

### Third step
To configure local environment variables
In the root project directory, there is a file called `build_env.sh`.

You can run it as follow:
```
./build_env.sh https://api.github.com
```
it will create `.env` in `modules/presentation/lib/environment/` file for you.


### Last step
Finally, you can run the application using the following command line:
- `melos run` in terminal select `rebuild all` and run it for all packages to make sure that all rebuilt successfully


# Testing
There is a melos script called `test_coverage`. It uses a tool called `lcov`. You need to install it on your mac. You can do that by running:

```
brew install lcov
```
once you are set with lcov, you can run the Melos script.

```
melos run test_coverage
```

it will generate the test coverage for your package/packages and put the results in the `coverage` folder.

### Visual Studio Code extensions
The results of the Melos script are possible to connect with Visual Studio Code. You need to do the following:

1. Install the `Flutter Coverage` extension
2. Install the `Coverage Gutters` extension
3. In VS Code change the `settings.json` (Code -> Preferences -> Settings -> search for `coverage` -> Edit in settings.json) and add:

``` bash
"flutter-coverage.coverageFileNames": [
    "lcov_cleaned.info",
],
"flutter-coverage.coverageFilePaths": [
    "modules/domain/coverage",
    "modules/remote/coverage",
    "modules/presentation/coverage",
],
```

4. Press the `Watch` button - which is at the bottom of the VS Code bar. 
5. See the coverage report separated by files and lines from the `Testing` tab in VS Code.