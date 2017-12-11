gwh hahah
开发阶段：
---------
1.首先要确定开发工作所涉及的文件是属于哪个分支  
2.获取feature分支的最新版本：  
  git checkout fea.xxx  
  git pull  
3.在feature分支进行开发，开发完成后进行提交，但不要推送到远端；  
  
代码测试：
---------
4.获取master分支的最新代码，将自己的测试分支重置到master分支的最新提交点：  
  git reset --hard xxxxxx  
5.merge本地的fea分支到测试分支：git merge fea.xxx  
6.将自己的测试分支推送到远端：git push origin test.xxx -f  
7.登录线上一台服务器，执行s3manager.py命令进入s3控制台，选择一台没有流量的服务器作为自己的测试机：  
  node autoinst test.tianhao 60.28.228.60  
8.在测试机部署代码：  
    
      cd /root/s2  
      /usr/local/bin/git fetch  
      export s2admin=<代码上线密钥>  
        <代码上线密钥>：系统管理员提供，对于test、alpha、beta级别的代码上线，使用每个人单独的密码，rc、stable级别代码使用管理员密钥)  
      cd /usr/local/s3hybrid/fcgi/  
      ./autoinst.py level set <levelname> <commit> 
        <levelname>：在s3manager中设置的level name，测试级别的level name有test.username、alpha.username、beta.username，正式上线级别有rc、stable。  
        <commit>：要上线分支的commit  
        示例：./autoinst.py level set alpha.tianhao e63daf1  
      查看安装状态的命令：node ls test.tianhao --show-revision  
    
9.进行测试，如果有问题在feature分支进行修改，并重复4至9步；
10.如果在测试机测试没有问题，从rc、stable服务器中挑选适当角色服务器按7至9步进行alpha、beta测试，并用"errlog.py cmd"命令行工具观察错误日志，如果有问题从第3步重新做。测试完成后将服务器恢复为原上线级别；
11.测试期间需要把代码给2+个人review一下。

stable上线：
------------
12.上线到rc和stable需要邮件通知下大家，确保同一时间只有一个人在上线 rc&stable；  
13.查看远端feature分支自从第2步操作后是否有新的提交，如果有新提交，从第2步开始重新做；  
14.查看远端master分支自从第4步操作后是否有新的提交，如果有新提交，从第4步开始重新做；  
15.按第8步方法上线rc和stable，并测试、观察errlog.py，如果出现问题，立即将代码回退到master分支的最新提交点，rc上线后观察一段时间没有问题再上线stable；  
16.把master分支reset到test分支并推送到远端，并把每一个提交点推到各自分支的远端；  
    
    git reset --hard test_head_commit  
    git push orgin master  
    git log --decorate --oneline --graph
    git push orgin commit:featurename  
    
17.发送上线完成邮件，通知大家合并master分支的最新内容，更新各自的alpha、beta测试机。  
18.可以通过这个页面查看是否有升级失败的：http://m.sinastorage.com:8001/serviceerr.html



export s2admin=s2admin:3HOletCxlbKX


        else:
            _err = rwrite[ 0 ]
            logger.warn( repr( rwrite ) + ' while copy_file' )
            raise err( 'InternalError', rwrite[ 0 ].__class__.__name__ )
