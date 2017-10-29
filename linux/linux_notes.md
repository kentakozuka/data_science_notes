Linux Memo

# Bus
bus
    ohci    Open Host Controller Interface
    hcd    Host Controller Device
    ehci    Enhanced Host Controller Interface
    uhci    Universal Host Controller Interface


# Command
    basic commands
        man
        apropos        man -kと同じ
        whatis         man -fと同じ
        makewhatis
        pwd            print working directory
    
    system
        free            メモリやスワップ領域の使用状況を表示
        uptime          現在のシステムの負荷平均を表示
        screen
        tmux        
        locale          現在のロケールの設定
        wall            ログインしているユーザ全員のコンソールに、引数で指定したメッセージを表示
    
    
    system statistics
        cifsiostat      Common Internet File System I/O Statistics
        nfsiostat       Network File System I/O Statistics
        top
        sar
        ps
        vmstat
        iostat
        mpstat
        swapon
        pidstat
        pstree
        lsof
        free
        netstat
        w
        uptime
    
    device
        lspci           PCIデバイスの情報を表示
        lsmod           ロードされているカーネルモジュールの情報を表示（/proc/modules）
        lsusb           USBデバイスに関する情報を表示（/proc/bus/usb/devices）
        dmesg            起動時にカーネルが出力したメッセージを表示

        mt              テープドライブを制御する
    
    library
        ldd             あるプログラム(コマンドなど)が必要としている共有ライブラリを表示
        ldconfig        共有ライブラリのキャッシュファイル「/etc/ld.so.cache」を更新
    
    shell variable
        set/unset       全ての環境変数とshell 変数を表示。shell変数を設定
        env             全ての環境変数を表示
        printenv        一部、または全ての環境変数を表示
        export          shell -> env
        declare         変数をオプションで指定した型で宣言する
    
    
    quota
        quota           指定したユーザやグループのディスククォータ状況を表示
        quotaon/quotaoffクォータを有効・無効化
        edquota         ユーザまたはグループのクォータを設定（viエディタ）
        setquota        ユーザまたはグループのクォータを設定（コマンドプロンプト）
        quotacheck      ファイルシステムのディスク使用量をチェック、dbファイルを作成・更新
        repquota        指定したファイルシステムのディスククォータ状況を表示
    
    permission
        uname
        groups
        id
        chmod
        chown
        chgrp
        ch
        unmask
    
    
    テキスト操作
        tr            （標準入力からのみ）
        cut
        wc
        od
        expand/unexpand
        split
        sort            行単位でファイルの内容をソート
        fmt             1行あたりの最大文字数を指定してテキストを整形
        sed             ファイルや標準入力の内容を編集して表示
        pr              ファイルを印刷用に整形
        uniq            ソートされているファイルにある重複した行を1行にまとめて表示
        nl              ファイルを行番号をつけて表示
        paste           複数のファイルを行単位で結合
        join            2つのファイルを読み込み、共通するフィールドがある行を結合して表示
        od              ファイルの内容を8進数や16進数で表示
        grep            文字列を検索
        egrep
        fgrep
        cpio            cpio形式のアーカイブを扱う（標準入出力のみ）
        rmdir           空のディレクトリのみを削除
        dd              データをコピー（デバイス可）
        xargs           標準入力から渡された文字列を、指定のコマンドの引数として実行
        iconv           文字コードを変換
    
    
    user & group
        passwd          ユーザーのパスワードを変更
        chage           パスワードの有効期限を変更（「/etc/shadow」）
        useradd         ユーザーアカウントを新規作成
        userdel         ユーザーアカウントを削除
        usermod         の設定を変更
        groupadd        グループアカウントを新規作成
        groupdel        グループアカウントを削除
        groupmod        グループアカウントの設定を変更
        id              ユーザーのUIDやGIDを表示
        groups          ユーザーの所属するグループを表示
        chsh
        last
        who
        ulimit
    
    
    security
        newaliases
        inetd
        xinetd
        visudo          「/etc/sudoers」ファイルを編集
        ulimit          ユーザやシェルが利用できるするリソースを制限する
        who / w         /var/run/utmpを参照。現ログインユーザー情報を表示
        last            /var/log/wtmpを参照。最近ログインしたユーザの一覧を表示
        fuser           リソースを使用中のプロセスを検索し、強制終了する
        lsof            リソースを使用中のプロセスを検索

# Permission
    1000            sticky bit(t)
    2000            SGID(set group ID)
    4000            SUID(set user ID)

		drwxr-xr-x 38 rails rails 4096 9月 17 09:18 2013 ..
		・一番左端の文字は、”d”はディレクトリで、”-“の場合はファイルです。
		・その右側の9文字がパーミッションの設定値です。最初の3文字分がファイルの所有者自身の権限、次の３文字が同一グループのユーザーの権限、最後の3文字がそれ以外のユーザーに対する権限です。
		　
			ファイル 	ディレクトリ
		“r”読み(4) 	ファイルの内容を表示 	ディレクトリ内のリスト表示
		“w”書き(2) 	ファイルの上書き、変更 	ディレクトリ内にファイル作成、削除
		“x”実行(1) 	実行ファイルの実行 	そのディレクトリに移動
		
		　
		２）パーミッションの設定方法
		
		chmodコマンドで設定します。
		　
		“testfile”というファイルに対して下記権限を付与する場合を例に示します。
		　
		所有者：読み(4)、書き(2)、実行(1)
		グループ：読み(4)、書き(2)、実行(1)
		他ユーザ：読み(4)、実行(1)
		　
		各権限に与えられている数値を足し合わせて下記コマンドで設定します。
		　
		$ chmod 775 testfile
		$ ls -al testfile
		-rwxrwxr-x 1 rails rails 0 9月 17 11:06 2013 testfile
		　
		３）誤解し易いディレクトリのパーミッション
		　
		　
		①読込権限がない場合
		　
		下記のようにディレクトリに対して読み込み権限が無いため拒否されます。
		　
		$ ls -al
		drwxrwx— 2 rails rails 4096 9月 17 09:39 2013 testdir
		　
		$ ls testdir
		ls: cannot open directory testdir: 許可がありません
		　
		②読込権限はあるが実行権限が無い場合
		　
		例）所有者が”rails”のディレクトリに対して他のユーザーが操作
		　
		下記のようにファイルの一覧は表示できますが、ディレクトリの実行権限が無いためディレクトリ内に移動する事はできず、ファイルの所有者、権限情報も表示できません。
		　
		$ ls -al
		drwxrwxr– 2 rails rails 4096 9月 17 09:39 2013 testdir
		　
		$ ls -al testdir
		ls: cannot access testdir/testevery: 許可がありません
		ls: cannot access testdir/testfile: 許可がありません
		ls: cannot access testdir/..: 許可がありません
		ls: cannot access testdir/.: 許可がありません
		合計 0
		d????????? ? ? ? ? ? .
		d????????? ? ? ? ? ? ..
		-????????? ? ? ? ? ? testevery
		-????????? ? ? ? ? ? testfile
		　
		$ cd testdir
		-bash: cd: testdir: 許可がありません
		　
		③読込、実行権限はあるが書込権限がない場合
		　
		下記のように、”testdir”内に移動する事はできますが、”testdir”に書込権限が無いためファイルを新規作成する事はできません。
		　　
		$ ls -al
		合計 12
		drwxrwxr-x 3 rails rails 4096 9月 17 09:26 2013 .
		drwxr-xr-x 38 rails rails 4096 9月 17 09:18 2013 ..
		drwxrwxr-x 2 rails rails 4096 9月 17 09:39 2013 testdir
		　
		$ cd testdir
		　
		$ touch testwrite
		touch: cannot touch `testwrite’: 許可がありません
		　
		④読込、実行、書込権限がある場合
		　
		$ ls -al
		drwxrwxrwx 2 rails rails 4096 9月 17 09:39 2013 testdir
		　
		ディレクトリに書込権限があるとファイルを新規作成できるようになります。ただし、ファイルの削除の権限も付与されてしまうので注意が必要です。
		　
		(a)ファイルの新規作成が出来るようになる
		　
		$ touch testwrite
		　
		$ ls -al
		-rwxrwxrwx 1 rails rails 0 9月 17 09:39 2013 testevery
		-rw-rw-r– 1 rails rails 0 9月 17 09:29 2013 testfile
		-rw-rw-r– 1 test-wp test-wp 0 9月 17 10:03 2013 testwrite
		　
		(b)ディレクトリに書込権限があると他のユーザーが所有するファイルも削除できてしまう
		　
		下記のように”testfile”は、他ユーザーに対しては書込権限を付与していないのでファイルに対して変更させたくないという意図があるにも関わらず、他のユーザーが削除出来てしまいます。
		ファイルの削除は、ディレクトリ権限で制御されているためです。
		　
		これを防ぎたい場合は、④で示すスティッキービットの設定を行います。
		　
		$ ls -al
		-rw-rw-r– 1 rails rails 0 9月 17 09:29 2013 testfile
		　
		$ rm testfile
		rm: remove write-protected 通常の空ファイル `testfile’? y
		　
		④他のユーザーにファイル作成は許可するが、他のユーザーのディレクトリ、ファイル削除は禁止したい場合
		　
		下記のようにディレクトリに対してスティッキービットを設定します。
		　
		スティッキービットが設定されているディレクトリに対しては、その配下のディレクトリ、ファイルの削除は、自分が所有しているものしか出来なくなります。
		　
		設定方法）
		下記のように、”chmod +t ディレクトリ名”で設定します。
		ディレクトリのパーミッション表示の一番右側に”t”が表示されるようになります。
		　
		$ chmod +t testdir
		　
		$ ls -al
		drwxrwxrwt 2 rails rails 4096 9月 17 10:07 2013 testdir
		　
		スティッキービットを設定すると、下記のように他のユーザーが所有するファイルは削除できなくなります。
		　
		$ rm testfile
		rm: remove write-protected 通常の空ファイル `testfile’? y
		rm: cannot remove `testfile’: 許可されていない操作です
		　
		⑤ディレクトリの実行権限は下の階層のディレクトリにも影響するので注意
		　
		例えば、下記のようなディレクトリがあった場合
		/home/rails/dir1/dir2/dir3/
		　
		dir1の書込権限を削除したとしても下層のdir2、dir3で急に書込出来なくなるということは無いと思いますが、dir1の実行権限を削除してしまうと、下層のdir2、dir3にも移動（アクセス）出来なくなってしまいます。
		　
		あるファイルに対して権限が足りなくて操作できない場合、書込権限の場合はその親ディレクトリの権限を見ればすぐに分かりますが、実行権限が足りなくて操作できない場合は、ずっと上位のディレクトリまで確認しなくはいけない場合があります。
		
# Environmental variables
    HISTFILE        コマンド履歴保存ファイルのパス
    HISTSIZE        コマンド履歴の保存数（現在のシェル）
    HISTFILESIZE    コマンド履歴の保存数（ファイル）
    HOSTNAME        ホスト名
    HOME            ログインしているユーザーのホームディレクトリ
    LANG            ロケール
    PATH            コマンドやプログラムを検索するディレクトリのパス
    PWD             pwdのパス
    USER            ログインしているユーザ名
    TZ              タイムゾーン
    LC_NUMERIC      数値の書式
    LC_TIME         日付・時刻の書式
    LC_MESSAGES     出力メッセージの言語
    LC_CTYPE        文字の分類、文字の種類の既定
    LC_ALL          指定した値が全てのカテゴリを上書きし、カテゴリごとの設定が不可能
    LANG            定した値が全てのカテゴリを上書きし、カテゴリごとの設定が可能


# manセクション番号
    1        user command
    2        system call
    3        lib function
    4        device file
    5        file format
    6        games
    7        micro-package, protocol, file system, etc.
    8        system administration command
    9        kernel rutine


# 8bitのdecimal
    1000:0000    128
    1100:0000    192
    1110:0000    224
    1111:0000    240
    1111:1000    248
    1111:1100    252
    1111:1110    254
    1111:1111    255


# 改行コード
    CR    Carrige Return    ←
    LF    Line Feed        ↓
    CRLF    CR+LF        ↵

# Process
    process/job
        ps              現在実行中のプロセスを表示
        pstree          プロセスの親子関係をツリー状で表示
        nice            nice値を指定してコマンドを実行
        renice          すでに起動しているプロセスのnice値を変更
        top
        jobs            bgで動作しているジョブと一時停止中のジョブを表示
        bg              bgで動作中または一時停止中のジョブを、fg動作に切り替える
        fg              一時停止中のジョブをbg動作に切り替える
        kill
        killall
        pkill
        nohup            ログアウト後もジョブを実行
        pgrep            実行中のプロセスから特定の名前を持つプロセスIDを検索

# Time Zone
    /etc/timezone        システムで使用するタイムゾーンを指定するテキストファイル
    /etc/localtime        システムで使用するタイムゾーンを指定するバイナリファイル

    date & locale
        date            システムクロックの表示や設定を行う
        hwclock        ハードウェアクロックの参照や設定を行う
        ntpdate            手動でNTPサーバから正確な時刻を取得し、システムクロックに反映
        locale            現在のロケールの設定
        
        tzselect            環境変数「TZ」や「/etc/timezone」ファイルで指定する値を表示
        tzconfig            「/etc/localtime」と「/etc/timezone」ファイルをまとめて設定


# Super Server
    xinetdの設定項目
        disable
            サービスを無効化するかの設定
            （yes:無効化、no:有効化）
        instances
            サーバプログラムの最大起動プロセス数
        lot_type
            ログの記録先指定。syslogや記録するログファイルの絶対パスを指定する。
        no_access
            サービスへのアクセスを拒否する接続元
        only_form
            サービスへのアクセスを許可する接続元
        server
            サーバプログラムの絶対パス
        server_args
            サーバプログラム起動時に指定する引数
        socket_type
            ストリーム型、データグラム型と行ったサービスの接続タイプ
        user
            サーバプログラムを起動するユーザ
        wait
            サーバプログラムへの接続処理を待ち合わせるかの設定。
            サーバプログラムがマルチスレッドであり1プロセスで同時に複数処理できる場合はno
            シングルスレッドで処理が完了しサーバプログラム終了まで処理が接続処理を待つ場合はyes。

    TCP Wrapper
        /etc/hosts.allow
            アクセス許可の設定
        /etc/hosts.deny
            ファイルでアクセス拒否の設定
        /etc/hosts.deny
            ファイルを使用せずに、/etc/hosts.allowファイルのみでアクセス制御の設定を行うこと
        書式
            <Service> : <IP Adress> : ALLOW
            <Service> : <IP Adress> : DENY

# ssh
                    ssh client              ssh server(sshd)
    設定ファイル    /etc/ssh/ssh_config     /etc/ssh/sshd.config
    秘密鍵          ~/.ssh/id_rsa           /etc/ssh/ssh_host_rsa_key
    公開鍵          ~/.ssh/id_rsa_pub       /etc/ssh/ssh_host_rsa_key.pub
    認証鍵リスト    ~/.ssh/known_hosts(1)   ~/.ssh/authorized_keys(2)
    
    (1) ホスト認証時に登録
    (2) ユーザ認証時に登録


# サーバー構築
    ルートでのsshログインを許可しない
    cat /etc/ssh/sshd_config
    PermitRootLogin no
    systemctl sshd restart
    systemctl sshd status


# Package
    pkg manager（Red Hat系）
        rpm             pkgのインストール・アンインストールなど、基本的なpkg管理を行う
        yum             パッケージのインストール・アンインストールなどを行う（=apt-get）
        rpm2cpio        RPM系パッケージをcpio形式のアーカイブに変換
        yumdownloader   パッケージファイルのダウンロードのみを行う
    
    pkg manager（Debian系）
        dpkg            pkgのインストール・アンインストールなど。基本的なpkg管理
        dpkg-reconfigureインストール済みのパッケージを再設定
        apt-get         pkgのインストール・アンインストールなどを行う（=yum）
        apt-cache       pkg情報の検索・参照
        aptitude        apt-getやapt-cacheよりも高機能。対話的なpkg管理が可能

    Arch Linux
        --Package Management
            Repositry
            >Official
                core
                extra
                community
                multilib
            >Testing-Repo
                testing
                community-testing
                multilib-testing
        
        
        Arch Building System (ABS)
            ・自作pkgのためのシステム
            ・makepkgツールを使用し、PKGBUILDという名前をBashスクリプトを処理してpkgをインストール
        
        Arch User Repository (AUR)
            非公式のレポジトリ
                (1) 手動
                    AURのサイトからPKGBUILDスクリプトをダウンロードしてmakepkgツールでインストール
                (2) 自動
                    yaourtを使用してインストール
                
Library
    static
        コンパイル時にコードがプログラムに組み込まれる。*.a
    shared
        プログラムの実行時にロードされる。*.so, *.sa
    dynamic
        shared libraryの一種。実行時に関数を使って、ロード・アンロードが可能。

Github --work flow--
    共有レポジトリで作業する場合
        Remote/originからclone
        ローカルで新しいworkブランチを作成（checkout）
        workブランチで作業
        add .
            git add .
        commit
            git commit -m "<Message>"
        Remoteにpush（Remoteリポジトリにブランチが作成される）
            git push <dest repository> <refspec>
            e.g. git push origin master
        GithubでPull Request & merge
        Githubでマージ済のブランチを削除
        ローカルのtrack用ブランチを削除（prune）
        ローカルブランチを削除（-D）


Input Method
    Input Method Framework (eg. iBus, Fcitx)
    Input Method (Engine) (eg. Mozc)

RAID
    RAID0
        striping. 2台以上のディスクを直列化し１台のディスクとする
    RAID1
        mirroring. 2台以上のディスクを並列化し１台のディスクとする
    RAID5
        3台以上のディスクで構成。
        パリティ領域と呼ばれるデータ復旧用の冗長なデータを各ディスクに分散し保持。
        RAID０とRAID１を合わせた構成。
    コマンド
        mdadm
            Multiple Device Administration

# X Window System
## コマンド
        xhost
        xvidtune        ディスプレイの表示位置を調整
        xwininfo        選択したXウィンドウの情報を表示
        xdpyinfo        ディスプレイの各種情報を表示
        xeyes

    /etc/X11/xdm
    xdim-config
    Xresources
    Xaccess
    Xsetup_0
    Xsession
    
    
    ❏　Commands
        xvidtune        ディスプレイの表示位置
        xwininfo        Xウィンドウ
        xdpyinfo        ディスプレイ
    
    
    ❏　Configuration
        /etc/X11/xorg.conf
    
    
    >sections
        ServerLayout    出入力デバイス
        Files           RGBのDBやFont
        Module          module
        InputDevice     入力デバイス
        Monitor         モニタータイプ
        Device          ビデオカード
        Screen          表示色数や画面サイズ
    
    
## Desktop Environment
        > Widget Toolkit (GUI Toolkit)
        > Window Manager
        > Display Manager
            GUIを描写・管理するソフトウェア
                ・ウインドウの配置
                ・ボーダーやタイトルバーなどのウインドウの追加的部品を描写
                ・ウインドウ間の相互作用や他のデスクトップ環境との相互作用を制御する
        
            ❏ コンポジット型ウィンドウマネージャ（Compositing window manager）
                コンポジット型ウィンドウマネージャはすべてのウィンドウの生成および描画を独立して行い、さまざまな二次元あるいは三次元環境でそれらを一緒に配置および表示する。
                これは高度な2Dおよび3D視覚効果によりそのインタフェースに多くの様々なルック&フィールの提供を可能としている。
                e.g.
                    Compiz
                    KWin
                    Xfwm
                    Mutter

            ❏ スタック型ウィンドウマネージャ
                すべてが同じ手法であるとは限らないが、ウィンドウを重なりあって描画し、コンポジット型でないウィンドウマネージャはすべてスタック型ウィンドウマネージャ（stacking window manager）である。
                スタック型ウィンドウマネージャは、まず背景ウィンドウを描画し、画家のアルゴリズムに従ってウィンドウを重ね合わせて表示することができる。
                e.g.
                    Blackbox
                    CTWM
                    Enlightenment
                    Fluxbox
                    FVWM
                    IceWM
                    JWM
                    Openbox
                    twm
                    Window Maker
                
            ❏ タイル型ウィンドウマネージャ
                タイル型ウィンドウマネージャ（Tiling window manager）は、画面全体を使ってウィンドウをそれぞれ上下左右に並べて配置し、原則として各ウィンドウが他と重なることがない。
                ウィンドウの生成、破棄によってウィンドウを指定されたレイアウトに基づき動的に再配置するウィンドウマネージャを動的タイル型ウィンドウマネージャという。
                相性の悪いGUIアプリも存在するため、任意のアプリをフロート配置できるウィンドウマネージャもあり、これを動的ウィンドウマネージャ（Dynamic window manager）と呼ぶこともある。
                e.g.
                    awesome
                    Bluetile
                    dwm
                    Ion
                    KWin
                    Larswm
                    Matchbox
                    Ratpoison
                    Scrotwm
                    WMFS
                    wmii
                    xmonad

            
        > Application / Utility
        > Taskbar
        > Terminal Emulator
        > File Manager
        > Calculator
        > Text Editor
        > Image Viewer
        > Media Player
        > Web Browser


# Shell Script
    ❏　メタキャラクタ
        [‘]（シングルクォーテーション)
            囲まれた部分を文字列とみなす（メタキャラクタを無視）
        [“]（ダブルクォーテーション）
            囲まれた部分を文字列とみなす（メタキャラクタを無視。ただし[$, `, \, “]を除く）
        [`]（バッククォーテーション）
            囲まれた文字列(変数の場合は、変数に格納されている値)をコマンドと見なす。
            コマンドの実行結果を文字列として使用

        Shell Script
        $?            直前に実行されたコマンドの実行ステータス
        $$            現在のシェルのPID
        $#            実行時に指定された引数の数
        $n            シェルスクリプトに渡されたn番目の引数（10以降は「${n}」と記述）
        
    ❏　コマンド
        seq             連続した数値を生成
        function            bash上で独自のシェル関数を作成
        alias            エイリアスを設定
        while            スクリプトにおいて、繰り返し処理を行う際に使用
        test            条件式を評価する際に使用
        read            改行またはEOFまでのデータを読み取り変数に格納
        source            指定したシェルスクリプトを読み込み、現在のシェルで実行
        exec            指定したコマンドを既存のジョブ(シェルのプロセス)と置き換えて実行

    >        上書き
    >>        追記
    <<        ヒアドキュメント
    <        入力


    > Sequence
        seq startNum endNum
        seq endNum (from 1)
        seq startNum incNum endNum
    
    > special variable
        $?    status
        $n    nth params (10- ${n})
        $$    current shell’s PID
        $#    the number of params
    
    
    > Condition
        -Num Compare
            eq    equal
            ge    greater than or equal
            le    less than or equal
            lt    less than
            ne    not equal
        
        
        -Files
            d    directory
            e    exist
            f    file
            r    readable
            w    writable
            x    executable
            nt    newer than
            ot    older than
        
        -Case
            case var in
                v1 ) result;;
                v2 ) result;;
            …
            esac

# Network
## コマンド
        arp             ARP キャッシュに関する操作       
        dig             DNSサーバへ指定したホスト名の登録情報を照会
        dnsdomainname
        domain
        getent          「/etc/nsswitch.conf」の設定に従って検索を行う
        gpg
        host
        hostname        一時的に自身のホスト名を変更する
        ifconfig        ネットワークインターフェースの情報の表示や設定を行う
        iwconfig        無線 LAN に関連した設定を行う
        iwlist 
        iwspy
        wpa_supplicant
        wpa_passphrase
        ip
        lsof
        nameserver
        nc              TCP/UDPを利用し様々な低レベルの操作を行う
        netstat         ネットワーク情報の表示
        > nmap            詳細が不明なネットワークの構造を調査したり、セキュリティ上の検査する目的で、ネットワークのスキャンを行う
        nslookup        DNSサーバに直接名前解決の問い合わせを行う
        ping            宛先アドレスに到達可能か確認
        route           TCP/IP ネットワークのルーティングテーブルの操作
        scp
        search
        ssh
        ssh-keygen
        > tcpdump         ネットワークを監視して、得られたパケット情報を表示する（パケットキャプチャ）
        tracepath       宛先アドレスまでの経路と経路上の最大転送速度を確認
        traceroute      宛先アドレスまでの経路を確認
        whois           ドメイン名の所有者情報が管理されているwhoisDBに指定したドメイン情報を照会

## Routing
        routing table
            Destination
                宛先のアドレス
                defaultはデフォルトゲートウェイ
            Gateway
                宛先へのゲートウェイ
                ＊は未設定
            Genmask
                宛先のサブネットマスク
                デフォルトゲートウェイは0.0.0.0
            Flags
                状態フラグ
                U   経路が有効
                H   対象をホストとして設定
                G   ゲートウェイを使用
                !   拒否する経路
            Iface
                宛先への経路で使用するインターフェース

## ネットワーク設定ファイル
        /etc/
            sysconfig/network-scripts/
                Red Had系。ディレクトリ内に ifcfg-eth[0-9] という名前
            network/interfaces
                Debian系。全体デバイス別設定
            hosts
                Debian系。ホスト名設定。クライアントマシン上でのみ有効なように設定を行う。
                よく接続するアドレスを設定しておくと便利。
                eg.
                    172.16.1.1    examhost.localdomain
            network
                ネットワーク名とネットワークアドレス対応の設定
                eg.
                    link-local    169.254.0.0
            nsswitch.conf
                名前解決の優先順位設定
                eg.
                    hosts: files dns
            protocols
                eg.
                    icpm    1    ICMP
            resolv.conf
                名前解決に使用するDNSサーバの設定
                eg.
                    nameserver    202.61.27.194
            services
                eg.
                    ftp-data    20/tcp

## MACアドレス
        IP アドレスを使う通信よりも下位のレイヤの通信に使うアドレスとして、MAC アドレスがあります。
        これは、それぞれの物理的なデバイスに一意に書き込まれているアドレスです。
        MAC アドレスにより物理的にそれぞれのデバイスを識別することができるので、同じネットワーク内のデバイス間ではこの MAC アドレスを使って通信を行うことができます。
        ユーザは IP アドレスにより通信先を指定してくるわけですから、何らかの方法で IP アドレスとそれに対応する MAC アドレスを変換できなければなりません。
        そのためのプロトコルが ARP です。
        ARP では MAC アドレスに変換したい IP アドレスを含む情報（パケット）をネットワーク内にブロードキャストし、その IP アドレスに該当するホストは自分の MAC アドレスを含む情報を送り返します。
        以上の方法で IP アドレスと MAC アドレスの対応関係が判明すれば、それを手元（ARP キャッシュ）にメモします。
        この ARP キャッシュにより、次からはいちいちブロードキャストを行わなくても、IP アドレスと MAC アドレスの相互変換が可能になる。

## アドレスの種類
        ユニキャストアドレス
            特定の機器を表すアドレス
        マルチキャスト
            特定グループ宛アドレス
        ブロードキャスト
            ネットワーク内の全ての機器宛アドレス

        > Global IP Address
            class   range                               net mask
            A         0.  0.  0.  0 - 127.255.255.255     255.  0.  0.  0
            B       128.  0.  0.  0 - 191.255.255.255   255.255.  0.  0
            C       192.  0.  0.  0 - 223.255.255.255   255.255.255.  0
            D       224.  0.  0.  0 - 239.255.255.255
            E       240.  0.  0.  0 - 255.255.255.255
            
            
        > Private IP Address
            class   range
            A        10.  0.  0.  0 -  10.255.255.255
            B       172. 16.  0.  0 - 172. 31.255.255
            C       192.168.  0.  0 - 192.168.255.255
            
            
        > Well-known ports
            No.     Protocol    Description
            20      FTP         data
            21      FTP         control
            22      SSH
            23      telnet
            25      SMTP
            53      DNS
            80      HTTP
            110     POP3        receive
            143     IMAP        receive
            199
            443     HTTPS
    
    > Routing Table
        宛先のIPアドレスやネクストポップををまとめた情報
    > Default Route
        ルーティングテーブルに該当する経路情報がない場合のルートを記述した情報
    > Default Gateway
        Default Routeでネクストポップに指定した機器
    
    
    x   使用できるホスト数
    h   ホスト部のビット数
    1   ネットワーク自身を表すアドレス
    1   ブロードキャストアドレス（ホスト部が全て1）
    n   その他
    
    x = 2^h -1 -1 -n


## LAN周り
        暗号化方式  Algorithm  完全性の検証 WEP     WPA     WPA2
        WEP         RC4        CRC32        必須    -       -
        TKIP        RC4        Mechael      -       必須    任意
        CCMP        AES        CCM          -       任意    必須
        
        
        WEP         Wired Equivalent Privacy
        RC4        
        CCMP        Counter mode with Cipher-block changing Message authentication code Protocol
        AES         Advanced Encription Standard
        WPA         wifi Protected Access
        TKIP        Temporal Key Integrity Protocol
        
        
## LAN規格
        The Institute of Electrical and Eletronics Engineers, Inc.
        IEEE        802.        11
        (学会名）   （委員会名）（グルール名）
        無線LANの技術仕様を規格化する。しかし、各ベンダ間の相互接続性は保証されない。
        
        
        ⇒Wi-Fi Alliance        業界団体
            無線LANの実装における認証プログラムを作成し、認証を与える。
            このWiFi認証にて相互接続性を確認する。この認証にパスするとWiFi表記できる。
        
        
        IEEE802.11
        b,a,g,n.ac        伝送規格
        i            セキュリティ規格
        e            QoS関連規格


## iptables
        iptablesとは、パケットフィルタリングやNAT（ネットワークアドレス変換）の設定を行う機能およびコマンド。
        Linuxカーネルにはnetfilterというのパケット処理機能が組み込まれていて、iptablesはこれを利用します。
        iptablesを正しく使用する為には、以下の「テーブル」や「チェイン」といった概念を理解する必要があります。

        【チェイン】
            チェインとは、パケットの処理方法を定義したルール群です。
            チェインにルールを追加していきます。
            チェインはどのタイミングでルールを適用するかを表します。
                INPUT
                    ローカルホスト（ローカルプロセス）宛のパケットに対してルールを適用
                OUTPUT
                    ローカルホストで生成されたパケットに対してルールを適用
                FORWARD
                    ローカルホストを経由するパケットに対してルールを適用
                PREROUTING
                    入ってきたパケットの内容を書き換えるためにルールを適用
                POSTROUTING
                    出て行くパケットの内容を書き換えるためにルールを適用

        【テーブル】
            いくつかのチェインのセット
            テーブルとは、iptablesで作成するチェインの使用目的を決定するもの。
            テーブルによって、デフォルトで使用できるチェインやターゲットに制限がかかる
            ルールの使用目的（フィルタリング or NATなど）を明確化する為に用意されています。

            > filter
                パケットフィルタリング用(デフォルト)
                デフォルトで「INPUT」「OUTPUT」「FORWARD」が使用できる
            > nat
                NAT用
                デフォルトで「OUTPUT」「PREROUTING」「POSTROUTING」が使用できます。
            > mangle
                特別なパケット変換に使用される。

            iptablesコマンドの「-t」オプションでのテーブル指定を省略した場合、常に「filter」テーブルを選択した事になります。


        以下はiptablesコマンドの使用例です。

            iptables -t filter -A INPUT -s 192.168.120.0/24 -j ACCEPT
            iptables -t filter -A INPUT -s 100.1.1.0/24 -j DROP

            「-t」オプションで「filter」テーブルを指定していますので、パケットフィルタリング用のルールについて操作する事を意味します。なお、「filter」テーブルの指定は省略可能です。
            「-A」オプションでチェインにルールを追加します。「INPUT」チェインにルールを追加していますので、ローカルホスト（ローカルプロセス）宛のパケットに対してルールが適用されます。
            「-s」オプションで送信元のIPアドレスを、「-j」オプションでターゲット（アクション）を指定しています。
            ターゲットとはパケットの具体的な処理方法であり、「ACCEPT」はパケットの通過を許可、「DROP」はパケットを破棄します。

        つまり上記のコマンドを入力すると、ローカルホスト宛のパケットをチェックし、送信元IPアドレスが192.168.120.0/24のパケットは許可、100.1.1.0/24のパケットは破棄します。

        iptablesコマンドの書式、および主なオプション、ターゲットは以下の通りです。
            iptables [-t テーブル名] –A|D チェイン ルール
                指定したチェインにルールを追加(-A)または削除(-D)
            iptables [-t テーブル名] –P チェイン ターゲット
                指定したチェインのポリシー(デフォルトとなるターゲット)を設定
            iptables [-t テーブル名] –L|F|X [チェイン]
                指定したチェインのルールを一覧表示(-L)、チェイン内のルールを全て削除(-F)、または空のユーザ独自チェインを削除(-X)
            iptables [-t テーブル名] –N チェイン
                指定した名前のユーザ独自チェインを新規作成


# cron & anacron
    ❏　cron
        word root
            cronos(chronicle)
        config file
            crontab        
        despription 
            定期的に自動でジョブを実行するには「cron」を使用します。
    
            デーモン名は「crond」です。
            ユーザ用と管理者が設定するシステム用の2種類の設定ファイル（crontabファイル）があります。
    
        コマンド
            at            1度だけ実行するジョブを予約
            atq            1度だけ実行するジョブを表示
            atrm            1度だけ実行するジョブを削除（at -d）
            crontab            ユーザ用のcronの設定を行う
            batch

    ❏　anacron
        anacronはcronによるジョブスケジューリングを補完するツールです。
        anacronの特徴は以下の通りです。
        ・日単位でジョブを実行する
        ・実行履歴を管理しており、未実行のジョブを検出できる
        ・デーモン化しないため、定期的に実行する必要がある。主にcrondにより実行。
    
    
    >実行プログラム
        /usr/sbin/anacron
    > config file（/usr/sbin/anacronから参照される）
        /etc/anacrontab
    > 実行履歴ファイル（/etc/anacrontab参照される）
        /var/spool/anacron/cron.daily
        /var/spool/anacron/cron.weekly
        /var/spool/anacron/cron.monthly

# Log
    > syslog
        /etc/syslog.conf
    >rsyslog
        /etc/rsyslog.conf
    >syslog-ng
    
    >system journal
        /etc/systemd/journald.conf
    
# Mail
    MTA
        Message Transfer Agent.
        SMTP(Simple Mail Transfer Protocol)とも呼ばれる。
        DNSサーバーに問い合わせ配送先MTAを調べ、メールを配送する。
        sendmailやqmail、Postfixなどのメールサーバソフトは、MDAの機能を内蔵している。
        つまり、ローカル配送プログラム（外部MDA）がなくても正しくメールは配送できる
            Postfix
                sendmailとの互換性を持ちつつ、新規に開発されたMTA。
                設定が容易でセキュリティーが高い
                単一のデーモンではなく、複数のプログラムで構成
                    主なプログラム
                        sendmail
                            sendmail互換インターフェース
                        smtpd
                            外部配送を処理する
                        pickup
                            maildropキューを監視し、内部配送を処理する
                        cleanup
                            ヘッダの書き換えなどを行ってincomingキューに入れ、qmgrに通知する
                        qmgr
                            キュー内のメールを配送プログラムに渡す
                        nqmgr
                            qmgrと同じだが配送アルゴリズムが異なる
                        master
                            全体の制御をするデーモン
                        bounce
                            バウンスメール（設定ミスなどで行ったり来たりする)を処理する
                設定ファイル
                    /etc/postfix/main.cf
                        MTAとしての基本設定ファイル
                        myhostname
                            自サーバのホスト名を指定
                        mydomain
                            自サーバのドメイン名を指定
                        myorigin
                            メールアドレスの@以降に使用するドメイン名を指定
                        inet_interfaces
                            メールを受け取るネットワークインターフェースを指定
                        mydestination
                            ローカル配送を行うドメイン名を指定
                        mynetworks
                            リレーを許可するクライアントを指定
                        mail_spool_directory
                            メールスプールディレクトリを指定
                        home_mailbox
                            ユーザのホームディレクトリ配下のメールスプールディレクトリを指定
                        mailbox_command
                            ローカル配送を行うプログラム（MDA）を指定
                        disable_vrfy_command
                            SMTPコマンドのVRFYの使用の無効化・有効化の指定
                            SMTPコマンドのVRFYはユーザのメールアカウントの有無を確認できます。
                            有効なメールアカウントを知られるとスパムメールを配信される可能性があるため、VRFYの使用は無効に設定しておくべき
                    /etc/postfix/master.cf
                        Postfixを構成する各種デーモンの設定ファイル
                        service
                            Postfixのサービス名の指定
                        type
                            サービスのタイプの指定。inetはインターネットソケット、unixはUNIXドメインソケット、fifoは名前つきパイプ
                        private
                            メールシステムのアクセス制限を行うかどうかの指定
                        unpriv
                            サービスをrootまたは所有者で動作させるかどうかの指定
                        chroot
                            chroot jail環境で動作させるかどうかの指定
                            「y」で、指定したデーモンをchroot jailモードで起動し、セキュリティを向上できます。
                        wakeup
                            サービスを何秒後に起動させるかを指定
                        maxproc
                            プロセスを同時に起動できる最大数の指定
                        command + args
                            サービスの実態プログラムと、その引数の指定
                    Commands
                        postfix
                            start
                                Postfixを起動
                            stop
                                Postfixを適切に停止
                            abort
                                Postfixを強制的に停止
                            flush
                                メールキュー内にあるメールを直ちに再送する
                            reload
                                設定ファイルを再読込する
                            check
                                設定ファイルの構文をチェックする
						postconf
							Postfixの設定内容を確認する

                メールのリレー
                    MTA間でのメールの中継
                    他のホスト宛てのメールを受け取った場合、MTAはそのメールのリレーを許可するか判断する。
                    基本的には
                        リレーを許可したいLAN内からのアウトバウンドメールは許可
                        リレーを許可したいドメインのメールは許可
                        外部からのアウトバウンドメールは拒否
    MDA
        Mail Delivery Agent
        宛先ユーザのメールボックスにメールを格納します。
    MUA
        Mail User Agent

			mutt

    MRA
        Mail Retrieval Agent
		ユーザのメールボックスに配信されたメールにリモートからアクセスできるようにするソフトウェアとしてMRA（Mail Retrieval Agent）が存在します。
		MRAは主にPOP3やIMAPを扱うソフトウェアのことを指します。

		代表的なMRA
			Dovecot
				POP3/IMAPをサポートする、多くのディストリビューションで導入されているMRA。
				Maildir及びmbox形式のメールボックス、SSL対応のPOP3/IMAPプロトコルであるPOP3S（POP3 over SSL）およびIMAPS（IMAP over SSL）もサポートしている。
                設定ファイル
                    /dev/dovecot.conf
			
			Courier-IMAP
				主にIMAPをサポートするMRA。
				Maildir形式のメールボックスのみをサポートしており、IMAPSにも対応している。
				専用の認証ライブラリであるCourier Authentication Library（courier-authlib）が必要となる。
    
    mail
        sendmail
        procmail
        mailq
        newaliases

# Printing
    CUPS (Common Unix Printing System)
    コマンド
        gs
        lp
        lpr
        lpstat
        lpq
        lpc
        cupsdisable

    > Ghost Script
        Post ScriptをRuster Dataに変換するインタプリタ
        （CUPSフィルタに似ている）
    
    > Ruster Data
        プリンタが認識できるバイナリの印刷データ
    
    > Post Scriptスト形式の印刷データ


コンピュータ・アーキテクチャ
    > Computer Architecture
        コンピュータシステムのハードウェア全体のソフトウエアインターフェースの定義。
        実装方法をマイクロアーキテクチャという。
        e.g.
            レジスタの構成
            命令とデータ型
            メモリマネジメント
            アドレッシングモード
            割り込み処理
            例外処理, etc…
    
    
    > ISA (Instruction Set Architecture)
        マイクロアーキテクチャ上に各種命令を構築した体系。
        (e.g. x86(32 bit), x86-64(i.e. x64: 64 bit), amd64(64 bit)
    
    > Micro Architecture
        プロセッサを設計する技術
    
    > Instruction Set
        命令セット。コンピュータのハードウエアに対して命令を伝えるための言葉の語彙

# Firmware
        記憶装置（HDD）等に関して最低限の認識
        ブートローダへの制御の移譲
    BIOS
        記憶媒体の先頭512バイト（i.e. MBRやPBR）にgurbのステージ1をインストール
        ステージ1のバイナリが/bootのあるパーティションのバイナリを読み込む
        つまり、ステージ1のバイナリはファイルシステムから見えない場所に書き込む

        IBM-PCの時に作られたBIOSは16bit Intel CPU前提のアークテクチャであるため，
        BIOSは，ディスク先頭の第一セクタしかロードできませんでした．
        よって，現在はその第一セクタ ― ディスク先頭512バイトの領域に
        ブートローダーとパーティションテーブル(MBR)を格納し，そのブートローダーからOSを起動するという仕組みが一般的．
        
        第一セクタ，つまりブートセクタをつかう方法は今や旧い方法．
        このブートセクタに置かれるブートローダーは容量の制約上技巧的な物にならざるを得ませんし，普通のファイルの容易に書き込みや入れ換えができるものでもないです．
        多段階的な方法を取らねばマルチブートできないのもBIOSの制約から来るものです．

    UEFI
        What's UEFI?
            ディスクの第1バーティションをUEFIシステムパーティション(i.e. ESP; Efi System Pertition)とする。
            UEFIはステージ1のバイナリはESPに書き込む
            ESPを使用する場合はディスクのパーティションテーブルをGPTで設定する。
            これによりは，パーティション数が最大128となり，1つのパーティションも2TiBの壁を越えて設定できます．
            システムのパーティションはFAT32
            ESPにはUEFIのSDKで記述したアプリケーションやブートローダーを配置．
            UEFIのアプリケーションバイナリはWindowsのEXE同様，PEバイナリとなります．
            UEFIのAPIを用いて記述したアプリケーションプロラムは，OSが起動する前の段階(pre-OS Environment)でUEFI内蔵のShellから起動する事ができます．
            以下の通り、UEFIが起動する
                1. UEFIがHDDを検出。GPTをロード
                2. EFI System Partitionを検索
                3. /EFI/boot/bootx64.efiをロード（32bit UEFIならbootx86.efi）
        
        UEFI Boot Maneger
            UEFIのファームウェアそのものにブートマネージャーというマルチブートの際のOS選択画面の機能のようなものが備わってます．
            このブートマネージャーに，ブートローダーやUEFIアプリケーションの表示するエントリ名と，システムパーティションでのパスを指定し，登録する事が可能です．
            よって，OS毎に専用のローダーをUEFI SDKで記述し，それぞれのローダーをこのブートマネージャーに登録するだけでマルチブートが可能となる．

            Intel CPUのReal modeでないとBIOSから起動できない，などという事がないため
            ブートローダーも16bitでなく32bitプロセッサなら32bit，64bitプロセッサなら64bitの命令がつかえるため，メモリも潤沢に使えます．
            ※ UEFIは64bitで起動したら64bitで、32bitで起動したら32bitのバイナリのみ実行できる

            sdx
            |-sdx1  /boot/efi
            |-sdx2  /
            |-sdx3  swap

        ESPへのGrub2インストール
            LinuxをUEFIから起動するときは、/boot/efiにUEFIシステムパーティションをマウントする
            そして、GrubはGrub2を使用し、
                $   grub-install
                        --target=x86_64-efi
                        --efi-directory=/boot/efi
                        --bootloader-id=<id-name>
                        --recheck
                        --debug
            とインストールする

            すると、/boot/grubにいつも通りのGrubの設定やローダーやフォントやモジュールといったファイル群が配置される
            そして、/boot/efi/EFI/<id-name>/grubx64.efiにステージ1のバイナリ（EFI Boot Stub）が置かれる
            このとき、efivarsというモジュールをロードしていると、grubは自動でefibootmgrを実行してUEFIを<id-name>という名前でブートローダを登録する
                ちなみにこれを自動でやるには、
                        $   efibootmgr -c -l <path-to-loader>
                                -L <id-name>

            UEFIによってはブータブルスタブ(EFI Boot Stub)が特定の名前で特定の場所に置かれていないと起動できないものがあります。
            念の為に以下のコマンドを実行しておきます。
                # mkdir /boot/EFI/boot
                # cp /boot/EFI/arch_grub/grubx64.efi  /boot/EFI/boot/bootx64.efi



        
# Boot Loader
## LILO
        設定ファイル
            /etc/lilo.conf
        メッセージ
            L
                BIOSがMBRに格納されている第1段階のブートローダをメモリにロード。「L」と表示。
            LI
                第1段階のブートローダが第2段階のブートローダ（/boot/boot.b）をロード。「LI」と表示。
            LIL
                第2段階のブートローダが実行。「LIL」と表示。
            LILO
                第2段階のブートローダがマップファイル（/boot/map）を正常にロード。「LILO」と表示。
                第2段階のブートローダがマップファイルの情報を元にカーネルをロード。

        エラーメッセージ
            何も表示されない
                何もロードされていない
                原因：
                    LILOの未インストール
            L <error code>
                第1段階のブートローダはロードしたが、第2段階のブートローダをロードできない
                原因：
                    ジオメトリ情報の不一致などのエラーコードによる
            LI
                第2段階のブートローダはロードしたが、第2段階のブートローダを実行できない
                原因：
                    ジオメトリ情報の不一致。/sbin/liloコマンドの未実行
            LIL
                第2段階のブートローダは実行したが、マップファイルからディスクリプタテーブルをロードできない
                原因：
                    ジオメトリ情報の不一致。ブートメディアの故障。
            LIL?
                第2段階のブートローダは実行したが、第2段階のブートローダが誤った場所にロードされている
                原因：
                    ジオメトリ情報の不一致。/sbin/liloコマンドの未実行。
            LIL-
                第2段階のブートローダは実行したが、ディスクリプタテーブルが壊れている。
                原因：
                    ジオメトリ情報の不一致。/sbin/liloコマンドの未実行
## GRUB Legacy
        設定ファイル
            /boot/grub/menu.lst
            (ディストリビューションによっては /boot/grub/grub.conf）

            それぞれの項目は以下のように使用します。
                title
                    各設定の名前を指定する項目
                    ここで設定した名前が GRUB の起動時メニューに表示されます。

                root
                    カーネルイメージや初期 RAM ディスクイメージの含まれているパーティションを指定
                    kernelやinitrdに記述したパスはrootに指定したパーティション上のパスと見なされる
                    パーティション指定には「root (hdディスク番号,パーティション番号)」のように記述。
                    その際、番号はどちらも0から数えます。

                    例）
                    1番目のディスクの1番目のパーティション　→　root (hd0,0)
                    1番目のディスクの2番目のパーティション　→　root (hd0,1)
                    2番目のディスクの2番目のパーティション　→　root (hd1,1)

                kernel
                    カーネルイメージファイルを指定する
                    kernel のパスは、root の項目で指定したファイルシステムにおけるパスとして記述。

                initrd
                    初期 RAM ディスクイメージファイルを指定する項目
                    kernel と同じく、root で指定したファイルシステムにおけるパスとして記述します。
    
## GRUB2
        設定ファイル
            /boot/grub/grub.cfg
                /boot/grub/grub.cfgファイルを直接編集することはない。
                設定内容は/etc/default/grubおよび/etc/grub.dディレクトリ内のファイルに記述
                update-grubコマンド
                    設定内容を/boot/grub/grub.cfgファイルに反映
                grub-mkconfigコマンド
                    実行すると、 設定を出力。
                    そのままでは標準出力に出力するので、「-o」オプションで出力先を指定します。
                    $ sudo grub-mkconfig -o /boot/grub/grub.cfg
                    update-grubを実行することはgrub-mkconfig -o /boot/grub/grub.cfgを実行するのと同じ

            /etc/default/grub
                全体的な設定ファイル
                grub-mkconfig が読み込む設定ファイル。
                grub-mkconfig はシェルスクリプトであり、 /etc/default/grub もシェルスクリプトとしてそのまま解釈します。
                ただ、基本的には、「パラメータ名=値」の羅列になっています。
                 主要なパラメータとその意味を、以下に示します。
                     GRUB_DEFAULT
                        デフォルトのOSを指定するためのパラメータです。
                        位置で指定することもできますし(先頭は0番です)、 メニューの名称をそのまま指定することもできます。
                        また、 「saved」と指定した場合、前回起動したOSがデフォルトになります。
                     GRUB_TIMEOUT
                        デフォルトのOSを起動するまでの時間を秒で指定するパラメータです。
                     GRUB_HIDDEN_TIMEOUT
                        これが指定されていると、メニューが表示されません。
                        また、これで指定された秒数だけ待ちます。
                     GRUB_HIDDEN_TIMEOUT_QUIET
                        true か false の値を指定します。
                        true だと画面に何も表示しませんが、 false だと GRUB_HIDDEN_TIMEOUT の残り時間を表示します。
                     GRUB_CMDLINE_LINUX
                        カーネルのコマンドラインオプションに追加したい場合に指定するためのパラメータです。
                     GRUB_CMDLINE_LINUX_DEFAULT
                        こちらは、通常起動の場合に、 コマンドラインオプションへ追加したいオプションを指定するためのパラメータです。
                     GRUB_GFXMODE
                        画面の解像度を指定するパラメータです。
                        ご使用の PC のグラフィックカードが対応する解像度をご指定ください。
                     GRUB_BACKGROUND
                        背景画像を指定するパラメータです。

            /etc/grub.d/
                00_header
                    /etc/default/grubファイルからGRUB2設定を読み込む。
                01_users
                    ブートローダーのパスワードがkickstartに割り当てられている場合にのみ、作成される。
                10_linux
                    Red Hat Enterprise Linuxのデフォルトのパーティションでカーネルを見つける。
                30_os-prober
                    別のパーティションで見つかったオペレーティングシステム用にエントリーを構築する。
                    自動にエントリを構築するため、期待通りに動作しない場合があるので注意が必要。
                40_custom
                    追加のメニューエントリー作成に使用可能なテンプレート。

                ※/etc/grub.d/ディレクトリからのスクリプトはアルファベット順に読み取られるので、
                名前を変更して特定のメニューエントリーの起動順を変更することができる。

                「README」で始まるファイルや「.dpkg-」とつくファイル以外で、 実行権のあるものは、すべて対象となります。
                これらは、前述の grub-mkconfig から起動され、 /etc/default/grub の設定にしたがった内容を出力。
                ですので、基本的には、 /etc/grub.d/ にあるファイルもあまり触らない方がよさそうです。 
                /etc/default/grub の指定だけではどうしようもないときにだけ、 手を加えればよいと思います。
                たとえば、 GRUB_CMDLINE_LINUX および GRUB_CMDLINE_LINUX_DEFAULT は、 「/etc/grub.d/10_linux」と「/etc/grub/20_linux_xen」で解釈されて、 Linux の起動のためのエントリ出力時に用いられます。 

                カーネルイメージ、ルートパーティションの指定

                menuentry
                    各設定の名前を指定する項目（GRUB Legacy の title に相当）
                    引用符内に名前を設定します。

                set root='(hdディスク番号,パーティション番号)'
                    カーネルイメージや初期 RAM ディスクイメージの含まれているパーティションを指定
                    （GRUB Legacy の root に相当）
                    GRUB Legacy と異なり、パーティション番号は1から数えます。

                    例）
                    1番目のディスクの1番目のパーティション　→　(hd0,1)
                    1番目のディスクの2番目のパーティション　→　(hd0,2)
                    2番目のディスクの2番目のパーティション　→　(hd1,2)

                linux
                    カーネルイメージファイルを指定する項目（GRUB Legacy の kernel に相当）

                initrd
                    初期 RAM ディスクイメージファイルを指定する項目（GRUB Legacy の initrd と同様）

                chainloader

            Multi-boot on GRUB2
                EFIの設定画面で立ち上げるOSを選択出来ますが手順が面倒。
                どれか1つのOSのgrub.cfgでマルチブートの設定をした方が簡便。

                EFIからはどれかひとつのOSのGRUB2を立ち上げて、そこでOSを選択する。
                GRUB2の設定ファイルgrub.cfgはLinuxのインストール時に生成されますが、
                インストール後にgrub-mkconfigコマンドを実行することでも生成できます。

                grub-mkconfigは/etc/grub.dの下のシェルスクリプトを順に実行することでgrub.cfgを生成します。
                    # ls -F /etc/grub.d/
                    00_header*        10_linux*      20_memtest86+*  30_uefi-firmware*  41_custom*
                    05_debian_theme*  20_linux_xen*  30_os-prober*   40_custom*         README

                上記のシェルスクリプトのうち、30_os-proberは他のOSを自動検知してエントリを登録するが、
                意図しないかたちで登録されたり、また再インストールした場合はパーティションのUUIDが変わったりして修正が面倒。
                そこでgrub-mkconfigを実行する前に「# chmod -x /etc/grub.d/30_os-prober」として30_os-proberを外してからgrub.cfgを生成する。
                そして、41_customが生成する設定を利用し、/boot/grub/custom.cfgをエディタで作成して、ここに他OSのエントリをすべて登録する。
                これだとあとでgrub-mkconfigを実行してもcustom.cfgの内容が変更されない。
                他のOSのエントリはchainloaderで各OSのブートローダを呼び出す設定にしました。
                以下、他のディストロでも同じ要領で可能。
                (menuentryの名前とchainloaderで指定するローダのパスが違うだけ)
                
                blkidコマンドを実行してEFI System PartitionのUUID(「UUID=」の後に表示される値。太字部分)を確認
                これをエントリのsearchコマンドの引数で指定します。
                
                    # vi /boot/grub/custom.cfg
                    menuentry "<os-label-name>" {
                          insmod part_gpt
                          insmod fat
                          insmod search_fs_uuid
                          insmod chain
                          search --fs-uuid --set=root --hint-bios=hd0,gpt1 --hint-efi=hd0,gpt1 --hint-baremetal=ahci0,gpt1 <UUID>
                          chainloader /EFI/<os-name>/<efi-file-name>.efi
                    }

## SYSLINUX
        FATファイルシステムからLinuxを起動する軽量のブートローダはSYSLINUXです。
        FATファイルシステムはMS-DOSやWindowsなどのOSで使用されるファイルシステムです。
        SYSLINUXは機能が少なく軽量で、フロッピーディスクやUSBメモリからの起動に主に使用されます。
## ISOLINUX
        CD-ROMで使用されるISO 9660ファイルシステムからLinuxを起動する

## PXELINUX
        PXE（Preboot Execution Environment）を使用してネットワークサーバからLinuxを起動する

## EXTLINUX
        ファイルシステムext2/ext3/ext4/btrfsからLinuxを起動する

# Kernel Modules
    カーネルモジュールは、カーネル本体の機能を拡張するものです。
    拡張部分を外部に出し、動的にロードして使うことで、カーネル本体のサイズを抑えて起動時間を短縮することなどが実現。
    カーネルモジュールとは、カーネルで扱うべき色々な機能を独立した部品にしたようなもの
    ビルド時にカーネル本体に組み込むことも、ファイルとして普段は切り離しておいて、必要なときにロードして使うこともできます。
    lib/modules/<kernel-version>/ にインストールされます。
    /その中に .ko という拡張子で配置されています。

    カーネルモジュールはカーネルのソースディレクトリで make modules を実行するなどしてビルドできますが、
    ビルドを行っただけではその新しいモジュールは有効になりません。
    make modules_install としてモジュールをシステムに配置（install）する必要があります。
    その際、デフォルトではモジュールは /lib/modules/(VERSION) 以下にインストールされます。
    カーネル本体がモジュールを利用する際には、このディレクトリが参照され、カーネルバージョンに合致したモジュールが動的にロードされることになります。
    ファイルとしてのカーネルモジュールは通常 /lib/modules/ 以下にカーネルのバージョンごとのディレクトリがあり、その中に .ko という拡張子で配置されています。

    ファイル
        /lib/modules/<kernel-version>/modules.dep/
            カーネルモジュールそれぞれが、別のどのカーネルモジュールに依存しているかという依存関係情報が書かれているファイルです。
        /lib/modules/<kernel-version>/modules.dep.bin
            Modules.depのバイナリファイル。

    コマンド
        modprobe があります。
            modules.depやmodules.dep.binファイルを利用して依存関係を解決する
            modprobe の設定ファイルでは以下が可能
                各モジュールのデフォルトパラメータを指定（options）
                モジュールに別名をつける（alias）、
                特定のモジュールのロード・アンロード時に実行されるコマンドを設定（install, remove）
        depmod
            modules.dep および modules.dep.bin を作成・更新する
        insmod
            モジュールを動的にロード
        rmmod
            モジュールを動的にアンロード
        lsmod
            現在有効にされているすべてのモジュールを表示
        modinfo
            モジュールを指定して、その情報を表示


# Initial RAM Disk (initrd)
     The only purpose of an initramfs is to mount the root filesystem. 
	 The initramfs is a complete set of directories that you would find on a normal root filesystem. 
	 It is bundled into a single cpio archive and compressed with one of several compression algorithms.

	At boot time, the boot loader loads the kernel and the initramfs image into memory and starts the kernel. 
	The kernel checks for the presence of the initramfs and, if found, mounts it as / and runs /init. 
	The init program is typically a shell script. Note that the boot process takes longer, possibly significantly longer, if an initramfs is used.

	For most distributions, kernel modules are the biggest reason to have an initramfs. 
	In a general distribution, there are many unknowns such as file system types and disk layouts. 
	In a way, this is the opposite of LFS where the system capabilities and layout are known and a custom kernel is normally built. 
	In this situation, an initramfs is rarely needed.

	There are only four primary reasons to have an initramfs in the LFS environment: 
		loading the rootfs from a network, loading it from an LVM logical volume, 
		having an encrypted rootfs where a password is required, 
		or for the convenience of specifying the rootfs as a LABEL or UUID. 
	Anything else usually means that the kernel was not configured properly. 

    背景
        Linuxディストロの多くは、なるべく広範囲なハードウェアでブートできるよう、単一の汎用的カーネルイメージで出荷されている。
        この汎用カーネルイメージのデバイスドライバ群はローダブル・カーネル・モジュールになっており、
        メモリの限られたコンピュータやフロッピーディスクなどの低容量媒体からもブートができるようカーネルイメージを巨大化させない工夫をしている。

        このような方式では、ルートファイルシステムをブート時にマウントするには、以下の問題が生じる。
            > 事前に（ルートファイルシステム上にある）必要なモジュールを検出してロードしなければならない
            > ルートファイルシステムがソフトウェアRAIDボリュームだったり、LVMだったり、暗号化されたパーティションだったりする
            > カーネルがハイバネーションをサポートしていること
                ハイバネーションとは、システムを停止させて、その時点の全システムイメージをスワップパーティションや普通のファイルにダンプし、電源を切る機能である。
                次回立ち上げたとき、そのイメージをメモリにロードするには、ディスク上のイメージにアクセスできなければならない。

    概要
        これらの特殊ケースに対応してカーネルにコードを加えるのを防ぐため、立ち上げの初期段階では一時的なルートファイルシステムを使う。
        このルートファイルシステムには真のルートファイルシステムのマウントに必要となる
            > ハードウェア検出
            > モジュールローディング
            > デバイス発見
        などのユーザー空間ヘルパーが存在する。

        Linuxでは、メモリ上にファイルシステムを作成するRAMディスクという機能や、ファイルをファイルシステムとしてマウントすることのできるループバックマウントという機能を持っています。
        このような仕組みを使用し、ファイルとして用意されているファイルシステムをRAMディスクとしてメモリ上に展開し、それを暫定的なルートファイルシステムとしてカーネルを起動し、その後本来のルートファイルシステムをマウントする、という起動方法をとることができます。
        この起動用のRAMディスクをinitrdといいます。
        例えば、ルートファイルシステムがSCSIハードディスク上にある場合、起動中に初期RAMディスクに配置しておいたSCSIドライバをロードすることで、ルートファイルシステムをマウントします。

        システム起動時に仮の環境としてまずメモリ上にファイルシステムを展開
        カーネルを動作させてから本来のファイルシステムをルートにマウントし直す
        といった段階的なブートを実現する。
        高度な機能を使うにはまずカーネルを動作させなければならないので、
        仮の環境でまずカーネルを動かして、それから本来の環境をブートさせようという発想。

        initrd とinitramfs（Linux 2.6.13 以降利用可能）の2種類の方式がある
        initrdと比較してinitramfsは、ファイルシステムのドライバが不要な点、メモリ効率が優れている点がメリットです


        初期 RAM ディスクはカーネル構築時に必要に応じて自動的に生成されますが、手動でインストールを行う場合
            mkinitrd
            mkinitramfs
            dracut
                オプションなしでdracutコマンドを実行すると、最新のカーネル用のinitramfsファイルが/boot以下に作成される
        で作成することができます。

    実装
        initrd のファイルシステムイメージ（およびカーネルイメージ）は、Linuxのブートローダやファームウェアがアクセスできる場所に格納しておく必要がある。
        これには、次のようなものがある。
            > ルートファイルシステム自身
            > ローカルディスク上の ext2 か FAT でフォーマットされた小さなパーティション（ブートパーティション）
            > Live CD の場合は、CD上のファイルシステム
            > TFTPサーバ（イーサネットからブートする場合）

    起動プロセス
        initrdの読み込み
            ブートローダはカーネルとinitrdイメージをメモリ上にロードし、カーネルを起動する際に initrd のメモリアドレスを渡す。
            ブートの最終段階で、カーネルはinitrdイメージの先頭数ブロックを読み込み、そのフォーマットを判断する。

                > そのイメージが（オプションでgzipで圧縮された）ファイルシステムイメージの場合、
                    特殊なブロックデバイス (/dev/ram) として利用可能にし、ルートファイルシステムとしてマウントする。
                    このファイルシステム用のドライバはカーネル内に静的にコンパイルしておく必要がある。
                    多くのディストリビューションではデフォルトで圧縮されたext2ファイルシステムをinitrdイメージに採用している。
                    初期化用ルートファイルシステムが利用可能になると、カーネルは最初のプロセスとして /linuxrc を実行する。
                    そのプロセスが終了 (exit) するとカーネルは真のルートファイルシステムのマウントが完了したと判断し、"/sbin/init" を実行して通常のユーザー空間の立ち上げ処理を開始する。

                > そのイメージがgzipで圧縮されたcpioアーカイブの場合、
                    中間段階としてカーネルがそれを展開して initramfs （Linux 2.6.13 以降利用可能なtmpfsの特殊インスタンス）とし、それを初期化用ルートファイルシステムとする。
                    ext2などのファイルシステムのドライバをカーネルに組み込んでおく必要がなくなるという利点がある。
                    initramfs 上で、カーネルは最初のプロセスとして /init を実行する。/init は終了 (exit) しない。

        マウント準備
            一部のLinuxディストリビューションでは、特定のコンピュータでのブートに必要なものだけを格納したカスタマイズしたinitrdイメージを生成する。
            その場合、ルートファイルシステムの場所や種類を実行時に判断するのではなく、initrdイメージ内に決めうちで書き込んでおくことが多い。
            他のディストリビューション（FedoraやUbuntuなど）はより汎用的なinitrdイメージを生成する。
            その場合、ルートファイルシステムのデバイス名（またはUUID）のみを使い、他の必要な情報はブート時に発見しなければならない。
            したがって、ルートファイルシステムをマウントするまでに以下のようなタスクが実行される。

                ・ブート処理が依存している任意のハードウェアドライバをロードしなければならない。
                ・通常、一般的なストレージ機器用カーネルモジュールをまとめてinitrdに格納しておき、ホットプラグエージェントを起動して、検出したハードウェアにマッチするモジュールを取出す。
                ・ブートスプラッシュを表示するシステムでは、画面表示関連ハードウェアを初期化し、ユーザー空間のヘルパーを使ってブート処理と同期しつつアニメーションを描画させる。
                ・ルートファイルシステムがNFSの場合、以下を行う。
                    主要なネットワークインタフェースを起動させる。
                    Procedure Call
            ネットワーク上にあるリモートホストの機能を別のホストから使用できるようにする仕組み
            RPCサービスにはRPCプログラム番号が付与され、その対応は/etc/rpcで確認可能
            RPCサービスが利用するTCP/UDPポート番号は動的に割り当てられる

# DHCP
    Dynamic Host Configuration Protocol
    サーバ側があらかじめプールしているIPアドレスを自動的にクライアントに割り当てるサービス
    IPアドレスと同時に、DNSサーバやデフォルトゲートウェイなどのネットワーク設定情報もクライアントに配信できる
    DHCPクライアントは、ネットワーク接続時に255.255.255.255宛のブロードキャストUDPパケットを送出します。
    DHCPサーバはこのパケットを受け取ると、プールしてあるIPアドレスの1つをクライアントに送りつけ（リース）、リース中のIPアドレス情報とクライアントのMACアドレスの対応テーブルを更新します。
    IPアドレスをクライアントに貸し出す期間をリース期間という。
    dhcpdが現在貸し出しているIPアドレスは、dhcpd.leasesファイルに記録されます。

	ホストに対して設定情報を割り当て、自動的に設定させるためのプロトコルです。
	クライアント・サーバ構成を取り、クライアントがサーバに対して設定情報を要求します。
	また、DHCPより以前にあったBOOTP（BOOTstrap Protocol）の上位互換であるため、DHCPサーバからBOOTPクライアントに設定情報を割り当てることもできます。
	サーバ、クライアント間の通信には、67/udp（サーバ側）および68/udp（クライアント側）のポート番号を使用します。

	DHCPサーバがクライアントに割り当てる情報には以下のようなものがあります。
		IPアドレス
		ドメイン名
		DNSサーバのアドレス
		デフォルトゲートウェイ
		サブネットマスク
		ブロードキャストアドレス
		NTPサーバのアドレス
		NISドメイン名
		NISサーバのアドレス
		WINSサーバのアドレス

	サーバの設定ファイル「/etc/dhcpd.conf」
        ISCDHCP
            デーモン
                dhcpd
            設定ファイル
                /etc/dhcpd.conf
                    option domain-name
                        ドメイン名
                    option domain-name-servers
                        DNSサーバ
                    option routers
                        デフォルトゲートウェイのIPアドレス
                    option subnet-mask
                        サブネットマスク
                    option broadcast-address
                        ブロードキャストアドレス
                    option ntp-servers
                        NTPサーバのIPアドレス
                    option nis-domain
                        NISドメイン名
                    option nis-servers
                        NISサーバのIPアドレス
                    option netbios-name-servers
                        WINSサーバのIPアドレス
                    default-lease-time
                        DHCPクライアントが期限を求めなかった場合のデフォルトリース期間（秒）
                    max-lease-time
                        DHCPクライアントが期限を求めた場合の最大リース
                    range [dynamic-bootp]
                        クライアントに割り当てるIPアドレスの範囲
                        dynamic-bootpフラグがあれば、BOOTPクライアントへ割り当てる
                    host
                        クライアントで固定IPアドレスを使用
                    fixed-address
                        固定で割り当てるIPアドレス
                    hardware
                        クライアントを特定するためのMACアドレス
    DHCPクライアント
        クライアントがDNS サーバを使用するには /etc/nsswitch.conf と /etc/resolv.conf ファイルを編集する必要があります。
        ソフトウェア
            dhclient
            pump
            dhcpcd

# PAM
	PAM（Pluggable Authentication Module）とは、 各種の認証処理を実行するモジュール群と、 
	それを利用するための標準的なAPI（Application Programming Interface）を備えたライブラリからなるユーザー認証システムのことです。 
	ユーザーに各種サービスを提供するアプリケーションプログラムは、PAMのAPIを通してPAMモジュールに認証処理を依頼することができます。 

	PAM には以下のようなメリットがあります。
    	アプリケーションから認証処理を独立させることができる。アプリケーションはPAMのAPIを利用するだけで認証を行える。
    	PAMはアプリケーションから見たインタフェースが標準化されているため、システムが異なってもソースの互換性が保たれる。
    	PAMモジュールを入れ替えることで、アプリケーションに手を加えずに認証方式を動的に変更できる。

	PAMのユーザー認証モジュールは、/etc/passwdファイルでユーザー名とパスワードを確認する代わりに、
	各種データベースサーバ（Oracleなどの、いわゆる普通のデータベースサーバやLDAPサーバなど）にパスワード情報を問い合わせて照合する機能を備えたモジュールと、
	ユーザーから受け取った認証情報を別のユーザー認証システム（RADIUSサーバなど）に渡して認証結果を得るモジュールの2種類に大別されます。

	通常、PAMの設定ファイルは「/etc/pam.d」ディレクトリにプログラムごとに用意されています。
	「/etc/pam.d」ディレクトリが存在しない場合は「/etc/pam.conf」ファイルにまとめて記述されます。
	なお、/etc/pam.dディレクトリと/etc/pam.confファイルの両方が存在する場合は、
	/etc/pam.dディレクトリ内の設定ファイルが利用されます（/etc/pam.confファイルは無視されます）。

	PAMの設定ファイルの書式
		モジュールタイプ　コントロール　モジュール　[引数]
		
		モジュールタイプ
			その行に記述されているモジュールに何をさせるのか、またはどのようなタイプの認証を行うのかを指定します。
			モジュールタイプには以下の4つがあります。
				auth
					パスワードを使用してユーザの認証を行う
				account
					ユーザのアカウントが有効かどうかをチェック
				password
					パスワードの設定および変更を行う
				session

		
		
		コントロール
			モジュールの実行に成功または失敗した際の処理方法を指定します。
			コントロールには以下の4つがあります。
				requisite
					モジュールの実行に失敗した場合は、すぐに認証を拒否し、
					以降の行にあるモジュールを実行しない。
				required
					モジュールの実行に失敗した場合、以降の行にrequiredのモジュールがあれば、
					そのモジュールを実行してから認証を拒否する。
				sufficient
					モジュールの実行に成功した場合、以前の行のrequiredのモジュールの実行がすべて成功していれば、
					その時点で認証を許可する。
					失敗した場合は、引き続き以降の行にあるモジュールの実行を続ける。
				optional
					モジュールの実行に成功または失敗した場合でも、以降の行にあるモジュールの実行を続ける。
		
		
		モジュール [引数]
			使用するモジュールを指定します。引数がある場合は引数を指定します。
			PAMのモジュールは「/lib/security」ディレクトリ配下に格納されています。モジュールを絶対パスで記述しない場合は、このディレクトリが参照されます。
			以下は主なPAMのモジュールです。
				pam_console.so
					端末（コンソール）から一般ユーザでログインした際、
					管理コマンドやデバイスなどの所有権を一時的に一般ユーザ権限に変更
				pam_cracklib.so
					パスワードの書式を制限し、安全性を向上
				pam_deny.so
					認証をすべて拒否
				pam_ldap.so
					LDAPを使用した認証を行う
				pam_limits.so
					ユーザが利用するリソースを制限
				pam_listfile.so
					任意のファイルを用いてプログラムのアクセス制限を行う
				pam_nologin.so
					/etc/nologinファイルがある場合、一般ユーザのログインを拒否
				pam_securetty.so
					rootでのログインを/etc/securettyファイルに記述された端末にのみ許可
				pam_unix.so
					通常のパスワード認証を行う
				pam_warn.so
					認証時やパスワードの変更時にログを記録
				pam_wheel.so
					root権限のアクセスをwheelグループのメンバーに制限
	
	
		以下はPAMの設定ファイルの例です。
		auth required pam_securetty.so
		auth required pam_unix.so nullok
		auth required pam_nologin.so
		
		この場合、pam_securetty.so、pam_unix.so nullok、pam_nologin.soと順番にモジュールが認証（auth）を実行します。
		requisiteやsufficientコントロールが無いため、最終行まで認証が実行され全てのモジュールが「成功」となっている場合に認証が許可されます。
		なお、上記例では全てのコントロールが required となっているため、いずれかの行でモジュールの実行に失敗しても最後の行までモジュールの実行を続け、その後、認証を拒否します。
		このようにすることで不正な侵入者に対し、どの時点で認証に失敗したのかという情報を隠す事ができます。

# LDAP
	Lightweight Directory Access Protocol
	Active Directoryのようなディレクトリサービスに、アクセスするためのプロトコル。
	クライアントはTCPポート番号389を使用してLDAPサーバに接続を行い、
	属性（個人名や部署名）で構成するエントリ（関連属性のまとまり）の検索、追加、削除の操作をします。

	LDAPはLightweight，という名前が示すとおり，
	DAP（Directory Access Protocol）と呼ばれる，	X500という規格で定義された，
	大がかりなディレクトリサービスで利用される通信プロトコルのサブセット版であり，
	このような目的に特化したプロトコルになります。
	先に述べたように，LDAPはクライアントからの検索クエリに対し適切な結果を返答したり，
	システム管理者が内容を自由に追加変更することができるデータベースとして機能します。

	LDAPの特徴
		1. テーブル構造ではなく木構造である
			リレーショナルデータベースでは「テーブル」と呼ばれる形式のデータ格納場所が用意され「レコード」ごとに要素は管理されますが，
			LDAPでは「ディレクトリ」と呼ばれる，階層構造により構成されます。
			たとえば，「⁠山川 しずか」というユーザ情報は「第一課」という「ディレクトリ」に所属し，
			さらに「営業部」という上位のディレクトリに所属します。最終的には「○×株式会社」という，組織上最上位のディレクトリに所属する，ということになります。
			データベースが木構造である，というメリットですが，
			ディレクトリ（階層）によるグルーピングを基礎とした構成となるため，
			管理の委任がしやすいこと，目的のユーザ情報がグルーピングされたディレクトリだけを指定して検索をするといった方法で，
			検索自体のパフォーマンスが有利になる，といった点があります。

		2. 主にテキストベースの情報を扱う
			リレーショナルデータベースでは，テキストベースのデータのほかバイナリベースのデータも同様に取り扱いますが，
			LDAPでは主にテキストベースのデータを取り扱います（バイナリデータを全く扱えないわけではありません）⁠。
			処理の負荷が少ないため，パフォーマンスが向上する傾向にあります。

		3. 最初から設定の項目が用意されている
			LDAPはディレクトリ検索のためのプロトコルとして，「⁠氏名」や「電話番号」「⁠メールアドレス」といっ、
			基本的な設定項目（属性といいます）が最初から定義されているため，
			リレーショナルデータベースのようにデータベース設計者が自分で定義する必要がありません。
			実際にはLDAPアプリケーション固有の属性が追加的に定義済みの状態でシステム管理者は利用しますが，
			「⁠LDAPスキーマ」という定義情報に自分で定義した属性情報を加えることもできます。
			現在のLDAPバージョンとなる，LDAPv3の詳細については，RFC 4511等で勧告されています。
	
	Open LDAP
		主な属性
			dn
				識別名(Distinguished Name)
			objectClass
				オブジェクトクラス
			c
				国名
			cn
				一般名称(Common Name)
			dc
				ドメイン構成要素（Domain Component)
			mail
				メールアドレス
			o
				組織名（Organization)
			ou
				部署などの組織単位(Organizational Unit)
			sn
				名字（SurName)
			telephoneNumber
				電話番号
			uid
				ユーザのログイン名
			uidNumber
				ユーザID
		OpenLDAPの管理用コマンド
			slapadd
				エントリの追加
			slapcat
				データベースからデータをLDIFファイルとして出力
			slaptest
				設定ファイル「slapd.conf」の構文をチェック
			slapindex
				設定ファイル「slapd.conf」で設定したインデックスを作成
			slappasswd
				サーバ管理者のパスワードをハッシュ化して生成
		バインド
			クライアントからLDAPサーバを操作する際、要求者が何者であるのかを確認するための認証作業が行われます。
			このことをバインドと言います。
			Linuxシステムでは認証にユーザ名とパスワードを使用しますが、LDAPではエントリのDNとそのパスワードを使用します。
			つまりDNはLDAPへのログイン時にユーザ名のような役割を果たします。

			Linuxシステムで、ログインしたユーザのアクセス権を制限できるように、
			OpenLDAPでも「slapd.conf」のaccessディレクティブを用いて、バインドしたDN(ユーザ)に応じたアクセス権の設定を行えます。
			例えば、バインドしたDN以外のエントリに設定されているパスワードは参照・変更することが出来ないように設定できます
			(ユーザ自身のみが自身のエントリのパスワードを参照・変更可能)。
		オブジェクトクラス
			LDAPでのオブジェクトの単位であるエントリは、必ずオブジェクトクラスに属しています。オブジェクトクラスによってエントリの実体(エントリが人を表すのか、組織を表すのかなど)が決定されます。
			オブジェクトクラスには以下の3つの種類（型）があります。
				ABSTRACT
					他のオブジェクトクラスを定義するための基底クラス。
					抽象型クラスのみでエントリを作成することはできない。
				STRUCTURAL
					人や組織等を表すオブジェクトクラス。
					エントリには必ず１つの構造型クラスが適用されている必要がある（変更不可）
				AUXILIARY
					補助型クラス。
					構造型クラスと共に使用するオブジェクトクラス。
					複数適用可。
					構造型クラスでは足りない属性を補う。
					補助型クラスのみでエントリを作成することはできない。

# DNS
    Domain Name Server
    ホスト名とIPアドレスを変換するシステム
    DNSサーバが問合せを受け付けるポート番号は53
    DNSサーバに冗長性を持たせる場合、マスターDNSサーバとスレーブDNSサーバを構築します。
    マスターDNSサーバは自身の持つゾーンファイル（ドメインの詳細情報が記載されたファイル）の内容を、スレーブサーバへ転送する事でゾーン情報を共有します。
    このオプションは、マスターDNSサーバの設定ファイルにおいて、スレーブDNSサーバのアドレスを指定する際に使います。

    ゾーンには以下の2つの種類があります。
        正引きゾーン：名前（FQDN）からIPアドレスを検索する
        逆引きゾーン：IPアドレスから名前（FQDN）を検索する

    正引きゾーンの作成だけで名前解決はできますが、一般的には逆引きゾーンも定義します。
    これはドメインの身元を明らかにする意味があります。
    例えば「www.example.co.jp」に対して「192.0.2.10」が得られた場合、
	再確認として「192.0.2.10」を逆引きした結果「mailserver.not-example.co.jp」が返ってくると、
	「正引きと逆引きでドメイン名が異なる＝詐称している」と判断することができます。
    よって管理するドメインとIPアドレスを一致させる意味でも正引き、逆引きの両方のゾーンを定義します。
        主なディレクティブ
            $ORIGIN
                補完するドメイン名。
                ホスト名のみで記述された名前に追加される。
            $TTL
                デフォルトTTL（Time To Live）を0-214783647の範囲で指定する
        主なリソースタイプ
            SOA(Start of Authority)
                書式
                    <ドメイン> IN SOA <ゾーンを管理するDNSサーバ名> <管理者のメールアドレス> (
                        ゾーン情報のバージョン;
                        ゾーン情報の推奨更新タイミング;
                        ゾーン情報の更新心配時のリトライ間隔;
                        ゾーン情報の有効期間;
                        ネガティブキャッシュの有効期間;
                    )
                ゾーンに関する情報を記述する。
                「ゾーン情報のバージョンは数字10桁で記述する。
                一般的には【更新年月日8桁＋通番2桁】とする。
                以下の情報はゾーン情報の複製を持つ「スレーブ」サーバが参照する。
                    ゾーン情報のバージョン
                    ゾーン情報の推奨更新タイミング
                    ゾーン情報更新失敗時のリトライ間隔
                    ゾーン情報の有効期間
                以下の情報は他のキャッシュサーバが参照する
                    ネガティブキャッシュの有効期間
            NS(Name Server)
                書式
                    <ドメイン> [TTL] IN NS <サーバ名>
                ゾーン情報を管理するサーバ名を記述する
            MX(Mail Exchange)
                書式
                    <ドメイン> [TTL] IN MX <優先度> <サーバ名>
                ゾーンで管理するドメイン宛メールの宛先メールサーバ名を記述する。
                優先度は0−65535の範囲で指定し、優先的に使用してほしいサーバに対して低い値を設定する
				あるドメイン宛にメールを送る場合、そのドメインのゾーンに登録されているMXレコードを参照します。
				送信側のSMTPサーバは、宛先ドメインのMXレコードに登録されている名前（FQDN）をもとに、名前から得られたIPアドレスのSMTPサーバに接続を行います。
				宛先となるSMTPサーバのアドレスを回答する正引きゾーンの設定においては
				「MXレコードに登録する名前はCNAMEで定義された名前（＝別名）を使ってはならない」というルール（RFC2181）があります。
            A(Address)
                書式
                    <名前> [TTL] IN A <IPアドレス>
                ゾーン内の名前に対応するIPアドレスを記述する。
                異なる名前を同じIPアドレスに割り当てることも、同じ名前を異なるIPアドレスに割り当てることも可能
            CNAME(Canonical Name)
                書式
                    <別名> [TTL] IN CNAME <元の名前>
                ある名前に対する別名を記述する
            PTR(Pointer)
                書式
                    <IPアドレス> [TTL] IN PTR <名前>
                IPアドレスに対応する名前（FQDN）を記述する。
                主に逆引きゾーンの定義に使用する。
                なお、ここでのIPアドレスはin-addr.arpaドメイン形式で表記する。

    DNSサーバには主に2つの機能があります。
        キャッシュサーバ
            LAN内のクライアントからの問合せに対し、クライアントに代わって他のDNSサーバに再帰的に（ルートDNSサーバから順に）問合せ、結果を回答するサーバです。
            その結果をキャッシュして、次回の問合せよりキャッシュ内の情報をクライアントへの回答に利用します。
        コンテンツサーバ
            自身が管理するゾーンに対する問合せのみ回答します。
            問合せ結果をキャッシュしたり、名前解決が出来ない場合も他のDNSサーバに問合せを転送しません。

    サーバソフトウェア
        djbdns
            キャッシュサーバ（dnscache）と、コンテンツサーバ（tinydns）の機能が分かれています。
            djbdnsはBINDより安全で設定が容易とされています。
        PowerDNS
            RDB（リレーショナルデータベース）などをバックエンドデータベースとして使用できるDNSサーバ
        dnsmasq
            DNSのキャッシュサーバやDHCPサーバなどの機能を持つソフトウェア
            BINDに比べて軽量で設定も容易ですので、簡易的なDNSキャッシュサーバとして利用できます。
        BIND（named）
            Linuxで標準的に使用されているDNSサーバです。DHCPサーバの機能はありません
            キャッシュサーバとコンテンツサーバの2つの機能をnameデーモンが担う
            設定ファイル /etc/named.conf
                optionステートメント
                    namedの動作詳細（オプション）を設定
                    directory
                        namedの作業ディレクトリ
                        /etc/named.conf内に記述した相対パスはここを起点とする
                    recursion[yes|no]
                        再帰的問い合わせを受け付けるかの設定
                        yesの場合はキャッシュサーバとしての役割を果たす
                    forwarders
                        自身が保持しないドメイン情報の問い合わせを転送するDNSサーバのアドレスを指定
                    forward[first|only]
                        問い合わせ転送の失敗時の動作を設定
                        first：失敗時に自分で問い合わせをする
                        only：失敗時に自分で問い合わせをしない
                    allow-query
                        問い合わせを受け付けるホストを指定
                    allow-recursion
                        再帰的問い合わせを受け付けるホストを指定
                    allow-transfer
                        ゾーン転送を許可するホストを指定
                        マスターDNSサーバにおいて、スレーブDNSサーバのアドレスを指定する
                    blackhole
                        問い合わせを受け付けないホストを指定
                    version
                        BINDのバージョンの問い合わせに対し、出力される文字列を設定
                aclステートメント
                    access control list
                    アクセス制御対象とするIPアドレスやネットワークアドレスのリストを任意の名前で定義
                controls
                    namedを操作するrndcコマンドの使用を許可するホストを指定
                include
                    指定された外部ファイルを読み込み、その内容を/etc/named.confに追加
                zone
                    ゾーン（管理するドメインの範囲）を定義
            ゾーンファイル
                ドメインの名前解決情報を記載したファイル
                $ で始まるディレクティブによる制御情報と、リソースレコードから構成されます。
            ログ
                /etc/named.confにログ出力に関する設定が行われていない場合、BINDはsyslogにログを送信します。
                syslogの出力するログファイルは設定ファイルによって出力先を指定できますが、デフォルトでは以下に出力される。
                    /var/log/messages（RedHat系）
                    /var/log/syslog（Debian系）

    digコマンド
        名前解決に関する各種情報を詳細に得ることができます。
        digコマンドで得られる情報は以下のグループごとにまとめられています。
            HEADER
                digコマンドの実行結果そのものに関する情報
                status: 問い合わせの実行結果（成功：NOERROR、存在しないドメイン：NXDOMAIN、など）
                flags: 実行して得られた応答のもつ意味（例：aaはAuthorative Answer、情報の管理元から回答が得られたことを意味する）
            QUESTION SECTION
                実行した問い合わせに関する情報。
                問い合わせた情報、リソースタイプ（A、MX、NSなど）が確認できる。
            ANSWER SECTION
                得られた回答に関する情報。
                問い合わせた情報、TTL、リソースタイプ、アドレス情報が確認できる。
            AUTHORITY SECTION
                得られた回答の原本情報を管理するDNSサーバの情報。
                このサーバのことを権威（Authority）DNSサーバと呼びます。
            ADDITIONAL SECTION
                追加で行った名前解決の情報。
                例えば、AUTHORITY SECTIONで表示されるDNSサーバの情報はFQDNのため、そのFQDNから得られるIPアドレスが表示される
            最後の4行では得られた回答に関する統計情報を表示
                Query time: 問い合わせにかかった時間
                SERVER: 問い合わせ先のDNSサーバ
                WHEN: 応答メッセージを受信した日時
                MSG SIZE rcvd: 応答メッセージのサイズ

Packet Filtering
    カーネルが処理するパケットの情報を調べて不要なパケットを通過させたり遮断したりすること。
    パケットフィルタリングは基本的に以下の３箇所で行う
        入力    INPUT
        出力    OUTPUT
        転送    FORWARD

    チェイン
        パケットを検査するための一連のルールセット
    テーブル
        いくつかのテーブルのセット
            デフォルトのfilterテーブル
            新しい接続を開くパケットのためのnatテーブル
            特別なパケット変換に使用されるmangleテーブル

    iptables

# Routing
    ルーティング・テーブル
    IPマスカレード
# OpenSSH
# OpenVPN
    Virtual Private Network
    仮想プライベートネットワーク
    インターネットなどの公衆ネットワークを介して、あたかも専用回線で接続されているかのように、プライベートなネットワークを構築する技術。
    インターネットは不特定多数が利用するため、盗聴や改ざんの危険性がありますが、VPNでは暗号化した経路を用意することで安全な通信ができます。
    Linuxでは、VPNを利用するのにOpenVPNを使用するのが一般的。
    OpenVPNは、IPはTCPなどのレイヤー2/レイヤー3プロトコルをSSL/TLSでカプセル化し、OpenVPNサーバとOpenVPNクライアントとの間のを安全に接続する。
    OpenVPNでは、PKI(Private Key Infrastracture)を利用する。
    第三者CAを利用せず自己署名証明書を使用できる。その場合、CA秘密鍵はOpenVPNサーバに用意する。

    接続方法
        ルーティング接続
            仮想トンネルネットワーク経由で異なるネットワークに接続する方法です。
            ルーティングを介して接続するので、OpenVPNクライアントとOpenVPNサーバは別々のネットワークが利用可能。
            LAN同士を相互に接続するような用途に向いています。
            大規模あアクセス制御にも対応できあます。
        ブリッジ接続
            仮想インターフェースで経由する方法。
            接続先ネットワークと同じネットワークセグメントのIPアドレスをOpenVPNクライアントの仮想インターフェース（TAPインターフェース）に割り当てることで、OpenVPNクライアントは接続先ネットワークに参加できる。
            ブロードキャストが届くので、SambaやWindowsサーバなどが利用できる。
            小規模なネットワークや個人で利用するにはブリッジ接続のほうが手軽。
    必要なファイルの作成
        パラメータの準備
        CA証明書、CA秘密鍵の作成
        サーバ証明書、サーバ秘密鍵の作成
        DHパラメータの作成
        クライアント証明書、クライアント秘密鍵の作成
        起動スクリプトの設定
    OpenVPNサーバの設定
    OpenVPNクライアントの設定

# Security
    

# Regular Expression
    Expression
        Basic
            \           退避修飾（エスケープ）
                        正規表現記号の有効/無効の制御
                        \の次にある正規表現記号を普通の文字として扱います。またアルファベット文字と組み合わせて特殊な意味を持たせたりします。
            |           選択子
                        パターンの論理和
            (...)       式集合（グループ）
                        パターンをグループ化。
            [...]       文字集合（文字クラス）
                        キャラクタクラス。
       
        Character Set(キャラクタクラス)
            [...]       [ABC]はAかBかCのどれかにマッチします。
            [^...]      否定
                        [^ABC]はAとBとC以外の任意の1文字にマッチします。
            [x-y]       範囲
                        [A-Z]は、「A」から「Z」までの文字のどれか1つとマッチします。
            [...]       (鬼) 文字集合内文字集合
            [..&&..]    (鬼) 積演算
            [:xxxxx:]   (鬼) POSIXブラケット
            [:^xxxxx:]  (鬼) POSIXブラケット（否定）
        
        量指定子(数量子)
            最小一致    最大一致 
            *?          *       直前のパターンの0回以上の繰り返し
            +?          +       直前のパターンの1回以上の繰り返し
            ??          ?       直前のパターンが0回または1回現われる
            {n}?        {n}     直前のパターンの n 回の繰り返し
            {n,}?       {n,}    直前のパターンの n 回以上の繰り返し
            {n,m}?      {n,m}   直前のパターンが n 回以上、 m 回以下

            正規表現Aを[A-Z_]*PROC 、正規表現Bを[A-Z_]*?PROC とする。
            SAKURA_COLLBACKPROC_BREXP_PROCという文字列中で、最初にマッチするのは以下になります。
                Aの場合: SAKURA_COLLBACKPROC_BREXP_PROC
                Bの場合: SAKURA_COLLBACKPROC
        
        Character
            \t          水平タブコード（HT,TAB）
            \n          ライン・フィード（LF）
            \r          キャリッジ・リターン（CR）
            \b          後退空白／バックスペース（BS）
                        [ ]の中でのみ有効
            \f          フォームフィード／改ページ（FF）
            \a          鐘／アラーム（BEL）
            \e          退避修飾／エスケープコード（ESC）
            \ooo        oに8進数で文字コードを指定する (oは1～3桁)
            \xHH        Hに16進数で文字コードを指定する (Hは1～2桁)
            \x{HHHH}    (鬼) 拡張16進数表現(Hは1～4桁)
            \c[         コントロール文字([はコントロール文字)
            \Q          (鬼) \Eに至るまで 正規表現演算子（正規表現記号）を抑制します
            \E          (鬼) 正規表現演算子（正規表現記号）の抑制状態を終端します
        
        文字種
            .           \nを除く任意の1文字 [^\n]と同じ
                        (Unicode版) 改行を除く任意の1文字。[^\r\n]と同じ *1
            \w          単語の構成文字 [0-9A-Za-z_]と同じ
            \W          単語の構成文字以外
            \s          空白類文字 [ \t\v\x0a\x0d]と同じ
            \S          空白類文字以外
            \d          10進数字
                        (Unicode版) 2バイト文字=全角数字も含む
            \D          10進数字以外
            \p{property-name}
                        (鬼) キャラクタプロパティ
            \p{^property-name}
            \P{property-name}
                        (鬼) キャラクタプロパティ（否定）
        
        Locater
            ^           行頭
            $           行末
            \b          単語の境界
                        [ ]の中ではバックスペースの意味になります
            \B          単語の境界以外
            \A          文字列の最初
            \Z          文字列の最後(最後が改行ならば改行の直前)
            \z          (鬼) 文字列の最後
            \G          照合開始位置
        
        後方参照と部分式呼び出し
            \n          番号指定による後方参照
                        ( )でグループ化した文字列を、\n(nは1以上の整数)で参照します。
            \k<name>
            \k'name'    (鬼) 名前指定による後方参照
            \k<name+n>
            \k<name-n>
            \k'name+n'
            \k'name-n'  (鬼) ネストレベル付き後方参照
            \g<name>
            \g'name'    (鬼) 名前指定部分式呼出し
            \g<n>
            \g'n'       (鬼) 番号指定部分式呼出し
        
        拡張式集合
            (?#...)     注釈
            (式)        捕獲式集合
            (?:式)      非捕獲式集合 （グループ化のみ）
            (?<name>式)
            (?'name'式) (鬼) 名前付き捕獲式集合
            (?=式)      先読み
            (?!式)      否定先読み
            (?<=式)     (鬼) 戻り読み
            (?<!式)     (鬼) 否定戻り読み
            (?>式)      (鬼) 原子的式集合
            (?imsx)     孤立オプション
            i:          大文字小文字照合
            m:          複数行（サクラエディタではデフォルトでon）
            s:          単一行 （. が \n にもマッチ）
            x:          拡張形式（空白を無視、# 以降を無視）
            (?imsx-imsx) 
                        (鬼) 孤立オプション（bregonig.dllではオプションの否定が可能）
            (imsx-imsx:式)
                        (鬼) 式オプション
        
        置換で使える参照
            「置換後」に指定して使います。
            $n          番号指定参照
                        ( )でグループ化した文字列を、$n(nは1以上の整数)で参照します。
                        サクラエディタでは$nの代わりに\nも使用できます。
            ${n}        (鬼) （安全な）番号指定参照
                        後ろにそのまま続けて数字を書くことができます。
            $&          マッチした文字列全体
            $+          (鬼) 最後にマッチした部分文字列
            $+{name}
            $-{name}[n] (鬼) 名前指定参照（Perl 5.10 互換、推奨）
            \k<name>
            \k'name'    (鬼) 名前指定参照（鬼車準拠）
            ${name}     (鬼) 名前指定参照（独自拡張、暫定仕様のため非推奨）

    Sample
        bから始まってkで終わる3桁の文字列               b.k
        bから始まってkで終わる2桁以上の文字列           b.*k
        bから始まってkで終わる3桁以上の文字列           b.+k
        半角数字                                        \d
        半角数字以外                                    \D
        数字列                                          \d+
        4桁の数字                                       \d{4}
        4桁以上の数字                                   \d{4,}
        4桁までの数字（1～4桁の数字）                   \d{1,4}
        4～10桁の数字（最長一致）                       \d{4,10}
        4～10桁の数字（最短一致）                       \d{4,10}?
        桁区切りのカンマ付数字列                        \b\d{1,3}(,\d{3})*\b
        価格（先頭が「\」の桁区切り付数字列）           \\\d{1,3}(,\d{3})*\b
        半角英大文字                                    \u
        半角英大文字以外                                \U
        半角英小文字                                    \l　　（※"l"は小文字のL）
        半角英小文字以外                                \L
        半角英文字                                      [\u\l]　　（※"l"は小文字のL）
        半角英字以外                                    [^\u\l]　　（※"l"は小文字のL）
        英単語（半角英文字列）                          \b[\u\l]+\b　　（※"l"は小文字のL）
        半角英数字                                      [\u\l\d]　　（※"l"は小文字のL）
        1桁の奇数                                       [13579]
        奇数                                            \d*[13579]\b
        3から7までの数字                                [3-7]
        0-9とA-Fのいずれかの2文字（2桁の16進数）        [0-9A-F]{2}
        全角数字                                        [０-９]
        全角英大文字列                                  [Ａ-Ｚ]+
        ひらがな                                        [ぁ-ん]
        カタカナ                                        [ァ-ヴ]
        半角ｶﾀｶﾅ                                        [ｦ-ﾟ]
        漢数字列                                        [一二三四五六七八九十壱弐参拾百千万萬億兆〇]+
        改行                                            \n
        半角スペース                                    \x20
        全角スペース                                    □　　(※□は全角スペース）
        タブコード                                      \t
        半角スペースかタブコードの繰り返し              [\x20\t]+
        空白文字                                        \s
        sampleという文字列（大文字小文字同一視）       (?i)sample
        sampleという文字列(samは大小文字同一視、pleは小文字限定)    
                                                        (?i)sam(?-i)ple
        amという単語                                    \bam\b
        単語の途中にあるam                              \Bam\B
        whで始まる3文字以上の単語                       \b[Ww]h.+?\b
        大阪または東京                                  大阪|東京
        大阪府または大阪市                              大阪(府|市)
        行頭の○                                         ^○
        行頭の半角スペースの連続                        ^\x20+
        行末の。                                        。$
        空白行                                          ^\n
        行全体                                          ^.*$
        郵便番号                                        (〒|ZIP：)\d{3}-\d{4}
        電話番号                                        0\d{1,4}-\d{1,4}-\d{4}
        携帯電話番号(ハイフンなし)                      0[89]0\d{8}
        メールアドレス                                  [\w.\-]+@[\w\-]+\.[\w.\-]+
        URL（ホームページアドレス）                     https?://[\w/:%#\$&\?\(\)~\.=\+\-]+
        日付                                            \d{4}[/\.年]\d{1,2}[/\.月]\d{1,2}日?
        見出しタグ開始（h1～h3まで）                    <[hH][1-3].*?>
        見出しタグ終了（h1～h3まで）                    </[hH][1-3]>
        sample の中の sam                               sam(?=ple)
        sample か samba の中の sam                      sam(?=ple|ba)
        後ろが「ple」ではない「sam」                    sam(?!ple)
        sample の中の ple                               (?<=sam)ple
        sample か apple の中の ple                      (?<=sam|ap)ple
        前が「saｍ」か「ap」以外の 「ple」              (?<!sam|ap)ple
        URL 　　　　　　　　　　　　　　　　　          http://[\w\d/%#$&?()~_.=+-]+
        HTMLタグ（テーブル）　　　　　　　　　          <TABLE.*?>
        リンクURL 　　　　　　　　　　　　　　          <a href="(.+?)".*?>[^<>]*?</a>
        リンクURL表示文字列 　　　　　　　　　          <a href=".+?".*?>([^<>]*?)</a>

# Apache Server
    Virtual Host
        バーチャルホストには以下の2つの種類があります。
        
        名前ベースのバーチャルホスト
            1つのIPアドレスに複数のドメイン名を設定します。
            名前ベースの場合、Listenディレクティブではなく、NameVirtualHostディレクティブで受け付けるIPアドレスの設定を行います。
            これでひとつのIPアドレスを複数のバーチャルホストで共有する事を示します。
            また、異なるドメイン名で同じIPアドレスを返すようにDNSを設定（CNAMEで別名を作成）する必要があります。
        
            例）IPアドレス192.168.1.105で「www.abc.com」と「www.xyz.com」を管理する場合
        
                # 2.4.6からは「NameVirtualHost」は影響しなくなりました。
                NameVirtualHost　192.168.1.105
        
                <VirtualHost 192.168.1.105>
                    ServerName www.abc.com
                    DocumentRoot /var/www/virtual/abc
                </VirtualHost>
        
                <VirtualHost 192.168.1.105>
                    ServerName www.xyz.com
                    DocumentRoot /var/www/virtual/xyz
                </VirtualHost>
        
        IPベースのバーチャルホスト
            複数のIPアドレスにそれぞれ異なるドメイン名を設定します。受け付けるIPアドレスの設定はListenディレクティブを使用します。
        
            例）IPアドレス192.168.1.105で「www.abc.com」を、IPアドレス192.168.1.106で「www.xyz.com」を管理する場合
        
            Listen 192.168.1.105:80
            Listen 192.168.1.106:80
        
            <VirtualHost 192.168.1.105>
                ServerName www.abc.com
                DocumentRoot /var/www/virtual/abc
            </VirtualHost>
        
            <VirtualHost 192.168.1.106>
                ServerName www.xyz.com
                DocumentRoot /var/www/virtual/xyz
            </VirtualHost>



    Apacheの設定ファイルhttpd.confでディレクトリ毎の設定を行う場合は、<Directory>セクションを利用します。
        しかし、例えばそれぞれのユーザが自身のホームディレクトリを公開していて、
        ディレクトリ（ユーザ）毎に異なる設定を行いたい場合は、
        管理者がディレクトリ（ユーザ）毎の設定をhttpd.confに記述するのはかなりの手間です。
        Apacheには、外部設定ファイルをそれぞれのディレクトリに配置することで、
        httpd.confの内容を上書き出来る機能が用意されています。

        外部設定ファイルを使用するには以下のようにします。

            AccessFileNameディレクティブで外部設定ファイルを指定する
                デフォルトの外部設定ファイル名は「.htaccess」です。

            AllowOverrideディレクティブで外部設定ファイルの利用を許可（または禁止）する
                AllowOverrideディレクティブで指定するパラメータによって、外部設定ファイルで使用できるディレクティブを制限することが出来ます。
                AllowOverrideディレクティブは、外部設定ファイルを許可するディレクトリの設定を行う<Directory>セクション内に記述する必要があります。

            外部設定ファイルを許可したディレクトリに外部設定ファイルを配置する
                外部設定ファイルの書式はhttpd.confと同じです。
                使用できるディレクティブが制限されている場合を除き、<Directory>セクションで記述が可能な設定を外部設定ファイルでも設定することが出来ます。

    ユーザ認証
        Basic Authorization
            BASIC認証を導入するための主な作業は以下のとおり

                htpasswdコマンドを使用しパスワードファイルの作成およびユーザの登録を行う
                    パスワードファイル名は通常「.htpasswd」が使われます。設置場所は外部からアクセス出来ない場所を選びます。

                必要であれば、グループファイルの作成およびグループの登録を行う
                    グループファイル名は通常「.htgroup」が使われます。
                    作成は手作業で行います。グループファイルの書き方は以下のとおりです。

                Apacheの設定ファイルhttpd.confまたは、外部設定ファイル.htaccessでユーザ認証によるアクセス制限を加えたいディレクトリの設定を行う

        Digest Authorization
            ダイジェスト認証を導入するための主な作業は以下のとおりです。
                htdigestコマンドを使用しパスワードファイルの作成およびユーザの登録を行う
                    パスワードファイルの新規作成は「-c」オプションを利用します。また、パスワードの変更およびユーザの追加はオプションなしで行います。

                必要であれば、グループファイルの作成およびグループの登録を行う
                    ファイルの作成は手作業で行います。グループファイルの書き方は以下のとおりです。

                Apacheの設定ファイルhttpd.confまたは、外部設定ファイル.htaccessでユーザ認証によるアクセス制限を加えたいディレクトリの設定を行う

            AuthType
                認証方式を指定
                Digest
            AuthName
                認可領域名を指定
            AuthUserFile
                作成したグループファイル名を指定
            AuthDigestGroupFile
                作成したグループファイル名を指定
            Require
                認証対象とするユーザまたはグループを指定
                ユーザの場合
                    Require user <ユーザ名> <ユーザ名> ...
                    e.g.
                        Require valid-user
                グループの場合
                    Require group <グループ名> <グループ名> ...

    DNSの逆引き設定
        DNSの逆引きとは、IPアドレスからホスト名への変換のことをいいます。
        HostnameLookupsディレクティブを「on」にすると逆引きが行われ、クライアントのホスト名がログに記録されます。
        接続数が増えるとサーバに負荷がかかるため、通常は「off」にします。
    
    IPアドレスによるアクセス制限
        Apacheではアクセス元のIPアドレス、ホスト名もしくはドメイン名を使用してアクセス制御を行うことが出来ます。アクセス制御にはApacheの設定ファイルhttpd.confのOrder、Allow、Denyディレクティブを使用します。
        Order、Allow、Denyディレクティブの書式は以下のとおりです。

        Order Allow,Deny|Deny,Allow
        Allow from IPアドレス｜ホスト名
        Deny from IPアドレス｜ホスト名

        Orderディレクティブで、AllowとDenyディレクティブの評価順を指定します。なお順序に関わらず、AllowとDenyディレクティブの内容は全て評価されます。

    モジュール
        Apacheで使用するモジュールには静的モジュールと動的（DSO）モジュールがあります。

        静的モジュール
            静的モジュールはApacheのインストール時に組み込む必要があり、Apacheの本体に組み込まれます。
            configure→make→make installの流れのconfigureスクリプトのオプションで指定することが出来ます。
            静的モジュールの利点は、Apache本体と一体となって動作するため、組み込みにかかる負荷が少ないということです。
            欠点は、静的モジュールの数を増やしすぎるとApacheが肥大化し、メモリの使用量が増えてしまうということです。

        動的モジュール
            動的モジュールはDSO（Dynamic Shared Object）モジュールと呼ばれます。
            apxsコマンドでコンパイルとインストールをし、httpd.confファイルのLoadModuleディレクティブで有効、無効を設定することができます。
            動的モジュールの利点は有効、無効の設定が簡単である、Apache本体のサイズを小さく出来るためメモリに負荷がかからないということです。
            欠点は、静的モジュールに比べて読み込む際に時間がかかるため、動作が遅くなるということです。

    Apacheの設定ファイルhttpd.confでディレクトリ毎の設定を行う場合は、<Directory>セクションを利用します。
    しかし、例えばそれぞれのユーザが自身のホームディレクトリを公開していて、
    ディレクトリ（ユーザ）毎に異なる設定を行いたい場合は、
    管理者がディレクトリ（ユーザ）毎の設定をhttpd.confに記述するのはかなりの手間です。
    Apacheには、外部設定ファイルをそれぞれのディレクトリに配置することで、httpd.confの内容を上書き出来る機能が用意されています。

    外部設定ファイルを使用するには以下のようにします。

        AccessFileNameディレクティブで外部設定ファイルを指定する
            デフォルトの外部設定ファイル名は「.htaccess」です。

        AllowOverrideディレクティブで外部設定ファイルの利用を許可（または禁止）する
            AllowOverrideディレクティブで指定するパラメータによって、外部設定ファイルで使用できるディレクティブを制限することが出来ます。
            なお、AllowOverrideディレクティブは、外部設定ファイルを許可するディレクトリの設定を行う<Directory>セクション内に記述する必要があります。

        外部設定ファイルを許可したディレクトリに外部設定ファイルを配置する
            外部設定ファイルの書式はhttpd.confと同じです。
            使用できるディレクティブが制限されている場合を除き、<Directory>セクションで記述が可能な設定を外部設定ファイルでも設定することが出来ます。

     以下はhttpd.confの外部設定ファイルに関するディレクティブをまとめたものです。
        AccessFileName
            外部設定ファイル名を指定（デフォルトは「.htaccess」）
        AllowOverride
            外部設定ファイルによるhttpd.confの上書きを許可
            指定できるパラメータ
                AuthConfig
                    認証関係の設定を許可
                Limit
                    Order, Allow, Denyディレクティブの設定を許可
                All
                    すべての設定の変更を許可
                None
                    すべての設定の変更を禁止

# Samba
	[global]
		username map = <file-name>
			ユーザ名のマッピング情報を格納したファイルを指定
		guest account
			ゲスト認証を許可する場合、ゲストユーザのユーザ名を指定
		map to guest
			Sambaユーザとして認証できなかった場合の対応を指定
		encrypt passwords
			暗号化されたパスワードを使用するかどうかを指定
		unix password sync
			LinuxとSambaのパスワードを同期させるかどうかを指定
		passwd program
			Samba側でパスワードを同期させるかどうかを指定
		null passwords
			空のパスワードを許可するかどうかを指定
	
	コマンド
		smbpasswd
			-a ユーザの追加
			-d ユーザの無効化
			-e ユーザの有効化
			-x ユーザの削除

NFS

	デーモン
		NFSv3ではサーバ側とクライアント側で下記のデーモンが稼働している必要があります。
		nfsdとmountdデーモンを起動するにはportmapデーモンが先に起動している必要があります。

		portmap　：サーバとクライアント側両方で必要になります。
			RPCプログラム番号をTCP/IPポート番号に変換するデーモンです。RPCについては「参考」を参照願います。
		nfsd　：サーバ側で必要です。
			ファイルシステムのエクスポートやNFSクライアントからの要求などを処理するNFSの中心となるデーモンです。
		mountd　：サーバ側で必要です。
			NFSクライアントからのマウントおよびアンマウント要求を受け付けるデーモンです。

	コマンド
		サーバ側
			rpcinfo
				 稼動しているRPCサービスの情報を表示するコマンド
			exportfs
				 NFSサーバのエクスポート状況を表示するコマンド
			nfsstat
				 NFSの統計情報を確認するためのコマンド
		クライアント側
			mount
				nolock
					ファイルをロックしない
				soft
					ソフトマウントする
				hard
					ハードマウントする
				retrans
					ソフトマウント時の再試行回数を指定
				intr
					ハードマント時の割り込みを受付
				resize
					読み取りのブロックサイズを指定（バイト単位）
				wsize
					書き込みのブロックサイズを指定（バイト単位）
	
	NFS ver.4
		NFSv4ではKerberos認証をサポートしており、従来のバージョンと比べセキュリティレベルが上がっています。
		また、mountdデーモンの機能がnfsdデーモンに取り込まれ、
		サーバとクライアント間の通信には2049番ポートのみを使用するようになりました。
		そのため、NFSv4はmountdおよびportmapデーモンを必要としません。

		なお、NFSv4では疑似ファイルシステムが採用されており、
		エクスポートするディレクトリは1つのツリーとして構成する必要があります。
		「fsid=0」 オプションを付けてエクスポートしたディレクトリがツリーの起点（/）となります。
		NFSv3ではクライアントはエクスポートされたディレクトリを個別にマウントする必要がありましたが、
		NFSv4ではツリーの起点である「/」をマウントするだけで済みます。

FTP
	FTPでは、制御用とデータ転送用の2つのポートを使用します。
	制御用ポートの接続要求は常にクライアント側から行います。
	データ転送用ポートの接続要求には、サーバ側またはクライアント側から行うかによって以下の2つの方法（モード）があります。

		アクティブモード
			データ転送用ポートの接続要求をサーバ側から行います。ポート番号は制御用に21番、データ転送用には20番が使用されます。

		パッシブモード
			データ転送用ポートの接続要求をクライアント側から行います。ポート番号は制御用に21番、データ転送用にはサーバが指定する任意のポート番号が使用されます。
	
	/etc/ftpusers」ファイルでは、FTPサーバにログインを許可しないユーザを指定することが出来ます。
	書式は以下のとおり、1行につき1ユーザで記載します。
		ユーザ名
		ユーザ名
		・・・
	
	FTPサーバに匿名ユーザがアップロードできるようにすると、
	不正なファイルの交換場所として使用されるなどの問題が起こりうるため、
	基本的には許可するべきではありません。
	どうしても必要な場合、「書き込みのみ許可し、読み取り許可しない」とすることで、
	匿名ユーザに対して「アップロードのみ」を許可できるようになります。

	なお、運用の例としては
	■ユーザ、グループ
		管理者は専用のユーザ（例：ftpadmin）、グループ（例：ftpadmin）
		匿名ユーザは専用のユーザ（例：ftp）、グループ（例：ftp）
	■パーミッション
		匿名ユーザのアップロードディレクトリは所有者・所有グループを管理者（ftpadmin:ftpadmin）、パーミッションを733（匿名ユーザに対して書き込み、実行権のみ付与）とする
		マスク値（ファイル作成時のパーミッション）を117（実行権なし、匿名ユーザには権限なし）とする
		アップロードされたファイルは必要に応じて管理者が移動、削除を行う
	というものが考えられます。
	実行権を付与しないのは、不正な実行ファイルがアップロードされたとしても誤って実行してしまうことを防ぐためです。

	代表的なFTPサーバ
		Pure-FTPD
			設定ファイル
				proftpd.conf
		vsftpd
			設定ファイル
				vsftpd.conf
		Pure-FTPD	
			設定ファイル
				pure-ftpd.conf

# SSH
	sshd
		/etc/ssh/sshd_config
			Protocol [1|2|1,2|2,1]
				受け付けるSSHプロトコルのバージョンを指定（デフォルト２）
			PermitRootLogin [yes|no]
				rootユーザのSSHログインを許可するかを指定（デフォルトyes）
			PubkeyAuthentication [yes|no]
				SSHプロトコルバージョン２で公開鍵認証を許可するかを指定（デフォルトyes）
			PasswordAuthentication [yes|no]
				パスワード認証を許可するかを指定（デフォルトyes）
			PermitEmptyPasswords [yes|no]
				空のパスワードを許可するかを指定（デフォルトno）
			X11Forwarding [yes|no]
				X11転送を許可するかを指定（デフォルトno）
			AllowUsers
				ログインを許可するユーザ
			DenyUsers
				ログインを禁止するユーザ
			AllowGroups
				ログインを許可するグループ
			DenyGroups
				ログインを禁止するグループ



# Directory Tree
/boot
    grub/
        grub.cfg
            GRUB2の設定ファイル
            または
        menu.lst
            GRUB Legacyの設定ファイル
    vmlinuz-<version>
        カーネルイメージ
    System.map-<version>
        カーネルのアドレスマップ
    initrc.img-<version>
        初期RAMディスクイメージ
    config-<version>
        ビルド時のカーネル設定

/proc/
    bus/
        pci/
            devices
                PCIデバイスに関する情報
        usb/
            devices
                USBデバイスに関する情報
    cmdline
        システム起動時にブートローダからカーネルに渡されたパラメータを表示
    dma
        DMAの割当に関する情報
    filesystems
        現在のシステムがサポートしているファイルシステムの種類の一覧
    interrupts
        IRQに関する情報
    ioports
        I/Oアドレスに関する情報
    meminfo
        メモリの使用状況を表示
    modules
        ロードされているカーネルモジュールに関する情報
    mounts
        現在マウントされているファイルシステムの一覧
        は読み出し専用の仮想ファイル
    scsi/
        scsi
            SCSIデバイスに関する情報を表示
    version
        カーネルのバージョン情報
        
/dev
    sda
        SCSI/SATA HDDの1番目
    sdb
        SCSI/SATA HDDの2番目
    sdc
        SCSI/SATA HDDの3番目
    sdd
        SCSI/SATA HDDの4番目
    hda
        IDE(ATA)のPrimary Master
    hdb
        IDE(ATA)のPrimary Slave
    hdc
        IDE(ATA)のSecondary Master
    hda
        IDE(ATA)のSecondary Slave
    sr0
        SCSI/SATA CD-ROMの1番目
    sr1
        SCSI/SATA CD-ROMの2番目
    st0
        SCSIテープの1番目
    st1
        SCSIテープの2番目
/etc
    aliases
        メールアドレスのエイリアス設定ファイル
    auto.master
        オートマウントのメインの設定ファイル
        左のフィールドから順に、マウントベース、マップファイル、オプションを指定
    fstab
        デバイス,マウント先,種類,オプション,dumpフラグ,fsckフラグ
        オプションは以下
            defaults    デフォルト指定
            auto        mount -aによる自動マウント対象
            noauto      mount -aによる自動マウント対象外
            ro          読み出しのみ許可
            rw          読み込み・書き込み共に許可
            exec        バイナリの実行を許可
            noexec      バイナリの実行を禁止
            async       非同期で入出力を行う
            sync        同期で入出力を行う
            uid         マウントしたファイルシステム上のファイルの所有者を指定する。
            nouser      一般ユーザによるマウントを禁止
            user        一般ユーザでマウント可。マウントしたユーザのみアンマウント可
            users       一般ユーザでマウント可。誰でもアンマウント可  
    grub.conf
        GRUB Legacyの設定ファイル
    hosts
        eg.    172.16.1.1    examhost.localdomain
    issue 
        ログインプロンプトの手前に表示される内容を設定
    modprobe.conf
        カーネルモジュールの設定ファイル
    modprobe.d/*.conf
        カーネルモジュールの設定ファイル
    motd
        ログイン直後に表示される内容を設定します。message of the day
    mtab
        現在マウントされているファイルシステムの一覧.普通の実ファイル
    network
        eg.    link-local    169.254.0.0
    nsswitch.conf
        eg.    hosts: files dns
    protocols
        eg.    icpm    1    ICMP
    resolv.conf
        eg.    nameserver    202.61.27.194
    services
        eg.    ftp-data    20/tcp
    systl.conf
        カーネルパラメータの設定ファイルkkk

/usr/src/linux
    .config
        カーネルのビルド設定ファイル
    Makefile
        makeの設定やカーネルバージョンが書いてある
    kernel/
        カーネル本体のソースが入っている
    Documentation/
        ドキュメント類が入っている
/var        
    log
        messages
            カーネルなどのログを表示
        secure
            セキュリティに関するログを表示
        maillog
            メールに関するログを表示

