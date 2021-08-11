# 版本库

版本库又名仓库，英文名`repository`，你可以简单理解成一个目录，这个目录里面的所有文件都可以被Git管理起来，

每个文件的修改、删除，Git都能跟踪，以便任何时刻都可以追踪历史，或者在将来某个时刻可以“还原”。

# git-init

通过`git init`命令把这个目录变成Git可以管理的仓库

发现一个warn是` LF will be replaced by CRLF in xxx` 这是因为这是因为在文本处理中，CR（CarriageReturn），LF（LineFeed），CR/LF是不同操作系统上使用的换行符，在windows系统和linux系统中换行是不同的处理方法，所以不用在意这个细节

# git-add-commit

添加文件到Git仓库，分两步：

1. 使用命令`git add <file>`，注意，可反复多次使用，添加多个文件；
   为什么Git添加文件需要add，commit一共两步呢？
   因为commit可以一次提交很多文件，所以你可以多次add不同的文件

```
$ git add file1.txt
$ git add file2.txt file3.txt
$ git commit -m "add 3 files."
```


2. 使用命令`git commit -m <message>`，完成。


+ 我在git的一个repository中的一个文件夹中修改了一个文件，使用`git status`命令，得到

`Changes not staged for commit:` 翻译是 `没有提交而暂存的更改：`

+ **git status命令可以让我们时刻掌握仓库当前的状态**，上面的命令输出告诉我们，readme.txt被修改过了，但还没有准备提交的修改。

+ 如果`git status`告诉你有文件被修改过，用`git diff`可以查看修改内容。

知道了对readme.txt作了什么修改后，再把它提交到仓库就放心多了，提交修改和提交新文件是一样的两步


+ commit 的意义在哪里
你不断对文件进行修改，然后不断提交修改到版本库里，

就好比玩RPG游戏时，每通过一关就会自动把游戏状态存盘，如果某一关没过去，你还可以选择读取前一关的状态。有些时候，在打Boss之前，你会手动存盘，以便万一打Boss失败了，可以从最近的地方重新开始。

Git也是一样，每当你觉得文件修改到一定程度的时候，**就可以“保存一个快照”，这个快照在Git中被称为commit**。一旦你把文件改乱了，或者误删了文件，还可以从最近的一个commit恢复，然后继续工作，而不是把几个月的工作成果全部丢失。


 `git log` 命令显示从最近到最远的提交日志



# git-reset  回退到上一个版本

如何回退到上一个版本呢，首先Git必须知道当前版本是哪个版本，在Git中，用`HEAD`表示当前版本，也就是最新的提交`1094adb...`（注意我的提交ID和你的肯定不一样），上一个版本就是`HEAD^`，上上一个版本就是`HEAD^^`，当然往上100个版本写100个^比较容易数不过来，所以写成`HEAD~100`
使用命令-->  ` git reset --hard HEAD^ `

### 此时如果你后悔了，想要再次回到未回退之前的版本怎么办？

其实，想要回到哪一个版本只需要直到那个版本的版本号即可，但是如何获取每一次commit的版本号呢

Git提供了一个命令`git reflog`用来记录你的每一次命令

一个例子 `git reset --hard 1094a`

## `git reset`总结

+ HEAD指向的版本就是当前版本，因此，Git允许我们在版本的历史之间穿梭，使用命令`git reset --hard commit_id`。

+ 想要回到过去版本，用git log可以查看提交历史，以便确定要回退到哪个版本。

+ 要重返未来（从过去版本回到现在版本），用git reflog查看命令历史，以便确定要回到未来的哪个版本。


# git 中的stage（工作区）的概念

分清楚`工作区`,`stage`,`master`三个区的概念
其实就是每次首先会在目录下工作区内做增删补的修改，通过`git add`的命令就会把所修改的东西存放到`stage`中去，可以多次`git add`命令，
使用`git commit `命令可以一次性把stage中的储存的所有修改全部提交给`master`

具体看链接 [工作区和暂存区](https://www.liaoxuefeng.com/wiki/896043488029600/897271968352576)


**为什么Git比其他版本控制系统设计得优秀，因为Git跟踪并管理的是修改，而非文件**

详细讲解，请看[管理修改](https://www.liaoxuefeng.com/wiki/896043488029600/897884457270432)

# git checkout 撤销修改

详细讲解还是需要看原文，下面是总结

+ 场景1：当你改乱了工作区某个文件的内容，想直接丢弃工作区的修改时，用命令`git checkout -- file`

+ 场景2：当你不但改乱了工作区某个文件的内容，还添加到了暂存区时，想丢弃修改，分两步，第一步用命令`git reset HEAD <file>` ，就回到了场景1，第二步按场景1操作。

+ 场景3：已经提交了不合适的修改到版本库时，想要撤销本次提交，参考版本回退一节，不过前提是没有推送到远程库。

# git-rm 删除文件

在工作区内删除一个文件，

+ 如果这个文件是需要丢弃的文件，不仅需要在工作区内删除（手动删除），此时版本库(reposity)中的文件也需要删除，所以使用`git rm <file> `然后` git commit `，注意不要忘了commit

+ 如果是你手残删错了，此时不用担心，使用git的好处就体现出来了，版本库里还有误删的文件，使用`git checkout -- <file> `命令，就可以恢复到版本库的最新版本

**`git checkout`  其实是用版本库里的版本替换工作区的版本，无论工作区是修改还是删除，都可以“一键还原”。**


# git remote add 添加远程仓库

要关联一个远程库，使用命令`git remote add origin git@server-name:path/repo-name.git`


关联一个远程库时必须给远程库指定一个名字，origin是默认习惯命名；

关联后，使用命令 ` git push -u origin master` 第一次推送master分支的所有内容；

此后，每次本地提交后，只要有必要，就可以使用命令 `git push origin master` 推送最新修改；

分布式版本系统的最大好处之一是在本地工作完全不需要考虑远程库的存在，也就是有没有联网都可以正常工作

# git clone 把远程仓库克隆到本地

要克隆一个仓库，首先必须知道仓库的地址，然后使用git clone命令克隆。

Git支持多种协议，包括https，但ssh协议速度最快。

# git的分支管理 <-- 以前一直没有搞懂的地方

分支在实际中有什么用呢？假设你准备开发一个新功能，但是需要两周才能完成，第一周你写了50%的代码，
**如果立刻提交，由于代码还没写完，不完整的代码库会导致别人不能干活了。如果等代码全部写完再一次提交，又存在丢失每天进度的巨大风险**。

在git中，其实相当于有一个`HEAD`控制版本，起到相当于控制在哪一个分支上操作的作用，在其中一个分支上工作并不会变动其他分支的情况，而后可以合并，具体讲解还是看 网站


+ 查看分支：`git branch`

+ 创建分支：`git branch <name>`

+ 切换分支：`git checkout <name>`或者`git switch <name>`

+ 创建+切换分支：`git checkout -b <name>`或者`git switch -c <name>`

+ 合并某分支到当前分支：`git merge <name>`

+ 删除分支：`git branch -d <name>`



# git解决分支管理的冲突

这种情况面对的是，在master上和一个分支上（比如创建了feature1分支）在同一个文件中的一个地方进行了改动，此时git当然无法确定到底使用那条分支上的改动，所以需要手动操作，git会在那个文件上使用`<<<<<<<`，`=======`，`>>>>>>>`标记出不同分支的内容

下面是那个网页上的一个示例
```
Git is a distributed version control system.
Git is free software distributed under the GPL.
Git has a mutable index called stage.
Git tracks changes of files.
<<<<<<< HEAD
Creating a new branch is quick & simple.
=======
Creating a new branch is quick AND simple.
>>>>>>> feature1
```

此时你需要做的是，手动打开那个文件进行编辑，改动完成后add commit即可

+ 当Git无法自动合并分支时，就必须首先解决冲突。解决冲突后，再提交，合并完成。

+ 解决冲突就是把Git合并失败的文件手动编辑为我们希望的内容，再提交。

+ 用`git log --graph`命令可以看到分支合并图。


# 分支管理策略 `git no diff`


在实际开发中，我们应该按照几个基本原则进行分支管理：

首先，master分支应该是非常稳定的，也就是仅用来发布新版本，平时不能在上面干活；

那在哪干活呢？**干活都在dev分支上，也就是说，dev分支是不稳定的，到某个时候，比如1.0版本发布时，再把dev分支合并到master上，在master分支发布1.0版本**

你和你的小伙伴们每个人都在dev分支上干活，每个人都有自己的分支，时不时地往dev分支上合并就可以了。

在那个网站上有一个图是言简意赅的，如果还是不理解可以去看那个网站


具体的流程和使用Fast Forward模式应该是差不多的

+ 1. 首先创建分支`git switch -c branchname`
+ 2. 对文件进行修改，然后 `git add <file>` 和 `git commit -m xxx`
+ 3. 切换回 master `git switch master`
+ 4. 合并分支 ` git merge --no-ff -m "message" branchname `
+ 5. 查看分支历史 `git log --graph ` 这样还可以有简易的图示


**合并分支时，加上`--no-ff`参数就可以用普通模式合并，合并后的历史有分支，能看出来曾经做过合并，而fast forward合并就看不出来曾经做过合并。**

## 丢弃一个没有被合并的分支

开发一个新feature，最好新建一个分支；

如果要丢弃一个没有被合并过的分支，可以通过`git branch -D <name>`强行删除。

# `git stash` （不过这个对我的用处好像并不大）

修复bug时，我们会通过创建新的bug分支进行修复，然后合并，最后删除；

当手头工作没有完成时，先把工作现场git stash一下，然后去修复bug，修复后，再git stash pop，回到工作现场；

在master分支上修复的bug，想要合并到当前dev分支，可以用git cherry-pick <commit>命令，把bug提交的修改“复制”到当前分支，避免重复劳动。



# 关于多人协作，远程仓库

在GitHub上面，每一个repository都有main分支，当然可以创建远程repository的远程分支，然后团队中的人clone远程分支到本地，然后建立远程分支和本地分支的联系，然后进行修改，将修改后的本地分支和远程分支合并，最后在github上将远程分支和main分支进行合并

因此，多人协作的工作模式通常是这样：

首先，可以试图用`git push origin <branch-name>`推送自己的修改；

如果推送失败，则因为远程分支比你的本地更新，需要先用`git pull`试图合并；

如果合并有冲突，则解决冲突，并在本地提交；

没有冲突或者解决掉冲突后，再用`git push origin <branch-name>`推送就能成功！

如果`git pull`提示`no tracking information`，则说明本地分支和远程分支的链接关系没有创建，用命令`git branch --set-upstream-to <branch-name> origin/<branch-name>`

这就是多人协作的工作模式，一旦熟悉了，就非常简单。

小结

查看远程库信息，使用`git remote -v`

本地新建的分支如果不推送到远程，对其他人就是不可见的
（注意当你的小伙伴从远程库clone时，默认情况下，你的小伙伴只能看到本地的master分支。现在，你的小伙伴要在dev分支上开发，就必须创建远程origin的dev分支到本地，于是他用这个命令创建本地dev分支`git checkout -b dev origin/dev `）

从本地推送分支，使用`git push origin branch-name`，如果推送失败，先用`git pull`抓取远程的新提交；

在本地创建和远程分支对应的分支，使用`git checkout -b branch-name origin/branch-name`，本地和远程分支的名称最好一致；

建立本地分支和远程分支的关联，使用`git branch --set-upstream branch-name origin/branch-name`

从远程抓取分支，使用`git pull`，如果有冲突，要先处理冲突。



# 解释为什么是 `git push origin master`，
当你从远程仓库克隆时，实际上Git自动把本地的master分支和远程的master分支对应起来了，并且，远程仓库的默认名称是`origin`

所以它的逻辑是 `git push 远程master分支名称 本地master分支名称`

而且Git自动把本地的master分支和远程的master分支对应起来，所以不用指定master之间的链接，但是它们的分支就不行了，需要指定本地dev分支与远程origin/dev分支的链接，这一条在上面 远程协作 上面已经讲过了




# `git rebase` 对目前的我帮助不大，没有细看

# git tag 对我目前来说意义不大，没细看

发布一个版本时，我们通常先在版本库中打一个标签（tag），这样，就唯一确定了打标签时刻的版本。将来无论什么时候，取某个标签的版本，就是把那个打标签的时刻的历史版本取出来。所以，标签也是版本库的一个快照。

tag就是一个让人容易记住的有意义的名字，它跟某个commit绑在一起（类似于C++的别名？）

# 如何在Github上参与开源项目

+ 1. Fork 别人的开源项目到自己的账号
+ 2. clone到本地然后进行修改，然后上传到Github账号
+ 3. 如果你希望的官方库能接受你的修改，你就可以在GitHub上发起一个pull request。当然，对方是否接受你的pull request就不一定了。



