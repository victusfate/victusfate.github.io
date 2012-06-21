show = (text, target) ->
	out = $("#" + target)
	out.hide()
	out.html text
	out.fadeIn()
	
# https://api.github.com/users/victusfate/repos

GetMyRepos = (uname) ->
	github_repo_api = "https://api.github.com/users/" + uname + "/repos?callback=?"
	console.log "GetMyRepos apiurl " + github_repo_api
	$.getJSON github_repo_api, (ob) ->
		repositories = ob.repositories
		names = []
		urls = []
		descs = []
		$(repositories).each (index) ->
			if this["master_branch"] == "gh-pages"
				s = this["homepage"]
				s = "http://" + s	unless s.match(/^[a-zA-Z]+:\/\//)
				$("#repos").append '<div id="repo"><a href="' + s + '">' + this["name"] + '</a>:  ' + this["description"] + '</div>'
			else
				if this["fork"] != true
					names.push this["name"]
					urls.push this["url"]
					descs.push this["description"]

		$(names).each (i) ->
			$("#repos_nopages").append '<div id="repo"><a href="' + urls[i] + '">' + names[i] + '</a>:  ' + descs[i] + '</div>'
		ob	
window.GetMyRepos = GetMyRepos

