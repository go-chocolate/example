
#git rev-parse HEAD
commitid=$(git rev-parse HEAD)
echo $commitid
datetime=$(date '+%Y-%m-%d %H:%M:%S')
echo $datetime

go build -ldflags "-X github.com/go-chocolate/example/version.BuildTime=$datetime -X github.com/go-chocolate/example/version.BuildHash=$commitid" -o bin/example