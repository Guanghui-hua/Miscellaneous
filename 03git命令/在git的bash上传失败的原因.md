# 远程repository名称是main而不是master

使用git 的bash 把东西上传到远端的repository总是出现`error: src refspec master does not match any`的错误，

意思是不匹配

疑惑了很久，最后终于搞清楚了，是用为远程repository的名称是main而不是master

所以命令应该更改为`git push origin main` 而不是`git push origin master`
