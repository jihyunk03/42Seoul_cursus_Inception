# 42Seoul_cursus_Inception

- `inception_version_00`: summary and test
- `inception_version_01`: test and evaluation


## yaml file
- `services`: docker compose 파일에서 하나 이상의 서비스를 정의하는 최상위 레벨 키로, 각 서비스는 독립적으로 구성할 수 있는 단위이며, 각각의 서비스는 하나의 컨테이너 또는 컨테이너 그룹을 나타낸다

- `build`: Dockerfile과 빌드 컨텍스트를 정의하여 이미지를 빌드하는데 필요한 설정을 제공한다
    - `context`: 빌드 컨텍스트를 지정한다. 이 디렉토리 내의 모든 파일이 Docker의 빌드 프로세스에 포함된다
    - `dockerfile`: 사용할 Dockerfile의 경로(파일 이름)를 지정한다 -> `default: Dockerfile`

- `container_name`: 컨테이너의 이름은 고유해야 하므로, 리스트 형태로 사용할 수 없다

- `:`은 `binding`한다는 의미라고 생각하자

- **`port`** vs **`expose`**
    - `port`: 외부와의 소통을 위한 포트라고 생각하자(`portNum1:portNum2`)
        - 컨테이너의 포트를 호스트 머신에 노출하여 외부에서 접근할 수 있도록 설정
        - 호스트 머신의 특정 포트를 컨테이너의 포트에 매핑하여 외부 접근을 가능하게 한다
        1. portNum1: 외부 호스트 포트번호로, 호스트 시스템에서 접근할 수 있는 번호이다
        2. portNum2: 내부 컨테이너의 포트번호로, 컨테이너 내부에서 사용되는 번호이다
    - `expose`: 내부와의 소통을 위한 포트라고 생각하자
        - 컨테이너의 포트를 외부에는 노출하지 않고, 동일한 Docker 네트워크 내의 다른 컨테이너에서 접근할 수 있도록 설정한다
        - 호스트 머신에서는 해당 포트에 직접 접근할 수 없다



## Nginx

> Nginx는 경량 웹 서버로, 클라이언트로부터 요쳥을 받았을 때 요청에 맞는 정적 파일을 응답해주는 HTTP Web Server로 활용되거나, Reverse Proxy Server로 활용하여 WAS 서버의 부하를 줄일 수 있는 로드 밸런서로 활용되기도 한다.

### WAS vs Web-Server
`WAS`와 `Web-Server`는 모두 웹 애플리케이션을 실행하기 위한 소프트웨어이다.
- 공통점: 클라이언트에게 정보를 전달한다
- 차이점:
    - `Web-Server`: HTML, CSS, 이미지 파일 등과 같은 정적 파일을 클라이언트에게 제공 (ex. nginx, apache)
    - `WAS`: 동적인 콘텐츠를 생성하고 처리하기 위한 기능을 제공하며, 데이터베이스와의 연동, 비즈니스 로직 실행, 세션 관리 등과 같은 웹 애플리케이션의 동적인 처리를 담당 (ex. spring, node-js, django)

### nginx를 사용하는 이유
1. `WAS`의 할일 분산

- 정적 콘텐츠는 nginx가 처리해주기 때문에 우리가 사용하는 서버의 부담이 줄어든다. 또한 nginx는 정적 파일을 효율적으로 서빙하는데 최적화되어 있어, 정적 파일의 전달에 매우 빠르고 경량적이기 때문에 웹 애플리케이션의 성능을 향상시킬 수 있다.

2. `reverse proxy`

- nginx는 `reverse proxy`로 사용할 수 있다. 이를 통해 클라이언트의 요청을 받아 웹 애플리케이션 서버로 전달하고, 애플리케이션 서버의 응답을 클라이언트에게 전달할 수 있다. 이때, nginx는 각 요청이 어디로 갈지 정해주는 역할을 한다.

- ex) 개발을 할 때 하나의 컴퓨터에서 서버를 실행하고, 여러개의 컴퓨터에서 접속을 한다고 생각해보자. 이 경우는 `reverse proxy`를 생각하기 어렵다. 하지만 서버를 실행하는 컴퓨터가 여러대일 경우, nginx가 클라이언트의 요청을 적절히 분배해서 이로 인한 부하(load)가 균형(balancing)있게 돌아가게 해주는 `load balancing`의 역할을 하게 된다

3. `caching`



## Dockerfile

> docker-image를 빌드하는 데 필요한 명령어와 지침을 포함한 텍스트 파일이다. 이 파일을 통해 다양한 명령어를 사용해서 이미지의 구성, 파일 시스템, 환경 변수 등을 정의할 수 있다.

- `RUN`: base OS를 지정하는 명령어로, 모든 `Dockerfile`은 반드시 이 명령어로 시작해야 한다.

- `CMD`: 컨테이너 내에서 명령어를 실행하고 이미지를 빌드한다. 주로 패키지 설치나 설정 변경에 사용된다.

- `WORKDIR`: 작업 디렉토리를 설정한다. 이후의 명령어들은 이 디렉토리 기준으로 실행된다.

- `COPY`: 로컬 파일이나 디렉토리를 컨테이너로 복사한다.

- `ENV`: 환경 변수를 설정한다.

- `ENTRYPOINT`: 컨테이너 시작 시 항상 실행되는 명령을 지정
    - entrypoint는 오버라이드되지 않으며, 고정된 실행 명령을 설정할 때 유용하다
    1. Exec 형식(권장): JSON 배열로 명령어와 인수를 설정
        ```Dockerfile
        ENTRYPOINT ["executable", "param1", "param2"]
        ```
    2. Shell 형식: shell 스크립트를 통해 명령을 실행
        ```Dockerfile
        ENTRYPOINT command param1 param2
        ```

> `Dockerfile`은 도커 이미지를 정의하는 텍스트 파일로, 작성 후에 `docker build` 명령어로 이미지를 빌드하고, `docker run` 명령어로 컨테이너를 실행할 수 있다.


## conf file

> configuration file을 의미하는 conf 파일은 다양한 소프트웨어 및 서비스의 설정 정보를 담고 있다. 이러한 파일들은 텍스트 형식으로 작성되며, 소프트웨어가 시작될 때 설정을 읽어들이고 그에 따라 동작을 제어한다.

### `.conf` vs `.cnf`
: 파일 확장자인 `.conf`와 `.cnf`는 기술적으로 차이가 없다. Docker에서는 파일의 확장자가 복사 동작에 영향을 미치지 않지만, 주로 다음과 같은 파일의 내용과 용도를 나타내기 위해 구분되기도 한다.

- `.conf`: 일반적으로 구성 파일을 나타내며, 다양한 애플리케이션의 설정 파일로 사용된다.
- `.cnf`: 주로 mySQL이나 MariaDB와 같은 데이터베이스 시스템의 설정 파일로 사용된다.

예시로 `my.cnf` 파일은 MariaDB 서버의 주 설정 파일로 `/etc/mysql/my.cnf`에 복사되고, `custom-config.conf` 파일은 추가 설정 파일로 `/etc/mysql/conf.d/custom-config.conf`에 복사된다.

### conf file 구조
: 구조는 소프트웨어에 따라 다를 수 있지만, 일반적으로는 `key=value` 쌍의 형태로 설정이 기록된다.

```conf
# This is a comment
; This is a comment

[section_name]
key=value
```
1. 주석(Comments)
    - 설명이나 메모를 기록하는 부분으로 실행 시 무시되는 부분
    - `#` 혹은 `;` 기호로 시작
2. 섹션(Sections)
    - 설정을 논리적으로 그룹화하는 데 사용됨
    - 대괄호 `[ ]`로 표시
3. 키-값(Key-Value Pairs)
    - 설정 항목을 나타내는 기본 단위
    - `key=value` 형식으로 기록



## mariaDB

### etc
- https://mariadb.com/resources/blog/how-to-install-and-run-wordpress-with-mariadb/

- https://ninano1109.tistory.com/152

### `mariadb --bootstrap`
: MariaDB 서버를 초기화 모드로 실행하여 데이터베이스 시스템 테이블 생성, 초기 사용자 설정 및 초기화 스크립트를 실행하는 데 사용된다.

### `mariadb`
: MariaDB 서버 데몬을 실행하는 일반적인 명령어로, MariaDB 서버를 정상적으로 실행하여 클라이언트 요청을 처리할 수 있게 한다.
- 서버 실행: MariaDB 서버를 실행하여 데이터베이스 클라이언트가 연결하고 쿼리를 실행할 수 있도록 한다.
- 지속적인 운영: 서버를 지속적으로 실행하여 데이터베이스 서비스 제공.



## WordPress

### download `wp-cli`
- https://make.wordpress.org/cli/handbook/guides/installing/

### config file
- https://myjeeva.com/php-fpm-configuration-101.html#pool-directives

### create wordpress shell
- https://ko.wordpress.org/download/#download-install
- https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
- https://github.com/WordPress/WordPress/blob/master/wp-config-sample.php
- https://nolboo.kim/blog/2016/05/16/ultimate-wordpress-development-environment-wp-cli/