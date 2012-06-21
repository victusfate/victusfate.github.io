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
        repositories = ob["data"]
        console.log "returned size " + repositories.length
        names = []
        urls = []
        descs = []
        $(repositories).each (index) ->
            if this["master_branch"] == "gh-pages"
                s = this["homepage"]
                s = "http://" + s   unless s.match(/^[a-zA-Z]+:\/\//)
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

SearchRepos = (key,language="") ->
    langstr = ""
    langstr = "?language="+language if language
    github_repo_api = "https://github.com/api/v3/repos/search/" + key + langstr + "?callback=?"
    console.log "GetMyRepos apiurl " + github_repo_api, "info-console"
    $.getJSON github_repo_api, (ob) ->
        repositories = ob.data
        names = []
        urls = []
        descs = []
        dates = []
        $(repositories).each (index) ->
                if this["fork"] != true
                    names.push this["name"]
                    urls.push this["url"]
                    descs.push this["description"]
                    dates.push this["created"]

#       $("#repos_nopages").append '<table cellpadding="0" cellspacing="0">'
        $(names).each (i) ->
#           $("#repos_nopages").append '<tr><td class="ghnum">' + i + '</td><td id="repo"><a href="' + urls[i] + '">' + names[i] + '</a> '+descs[i]+' <span style="color:#0086B3;">'+dates[i]+'</span></td></tr>'
            $("#repos_nopages").append '<div id="repo"><a href="' + urls[i] + '"' + 'color="#0086B3">' + names[i] + '</a> '+descs[i]+' <span style="color:#0086B3;">'+dates[i]+'</span></div>'
#       $("#repos_nopages").append '</table>'

        ob
window.SearchRepos = SearchRepos
