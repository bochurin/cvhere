Todo Tree
This extension quickly searches (using ripgrep) your workspace for comment tags like TODO and FIXME, and displays them in a tree view in the activity bar. The view can be dragged out of the activity bar into the explorer pane (or anywhere else you would prefer it to be).

Clicking a TODO within the tree will open the file and put the cursor on the line containing the TODO.

Found TODOs can also be highlighted in open files.

Please see the wiki for configuration examples.

screenshot

Notes:

User rg.conf files are ignored.
Highlighting
New!: If you just want to set different colours for tags, you can now enable todo-tree.highlights.useColourScheme. This will apply a set of colours (which can be changed) to the tags in the order that they are defined.

Highlighting tags is configurable. Use defaultHighlight to set up highlights for all tags. If you need to configure individual tags differently, use customHighlight. If settings are not specified in customHighlight, the value from defaultHighlight is used.

Custom highlights can also be specified for sub tags (if used).

Note: defaultHighlight is not applied to sub tags.

Both defaultHighlight and customHighlight allow for the following settings:

foreground - used to set the foreground colour of the highlight in the editor and the marker in the ruler.

background - used to set the background colour of the highlight in the editor.

Note: Foreground and background colours can be specified using HTML/CSS colour names (e.g. "Salmon"), RGB hex values (e.g. "#80FF00"), RGB CSS style values (e.g. "rgb(255,128,0)" or colours from the current theme, e.g. peekViewResult.background. See Theme Color for the details. Hex and RGB values can also have an alpha specified, e.g. "#ff800080" or "rgba(255,128,0,0.5)".

opacity - percentage value used with the background colour. 100% will produce an opaque background which will obscure selection and other decorations.

Note: opacity can only be specified when hex or RGB colours are used.

fontWeight, fontStyle, textDecoration - can be used to style the highlight with standard CSS values.

borderRadius - used to set the border radius of the background of the highlight.

icon - used to set a different icon in the tree view. Must be a valid octicon (see https://octicons.github.com) or codicon (see https://microsoft.github.io/vscode-codicons/dist/codicon.html). If using codicons, specify them in the format "$(icon)". The icon defaults to a tick if it's not valid. You can also use "todo-tree", or "todo-tree-filled" if you want to use the icon from the activity view.

iconColour - used to set the colour of the icon in the tree. If not specified, it will try to use the foreground colour or the background colour. Colour can be specified as per foreground and background colours, but see note below.

Note: Theme colours are only supported when using codicons. Hex, RGB and HTML colours are only supported when using octicons or the default icon.

gutterIcon - set to true to show the icon in the editor gutter.

Note: Unfortunately, only octicons and the todo-tree icon can be displayed in the gutter.

rulerColour - used to set the colour of the marker in the overview ruler. If not specified, it will default to use the foreground colour. Colour can be specified as per foreground and background colours.

rulerOpacity - used to set the opacity of the ruler markers.

Note: Only works with hex and RGB colour settings.

rulerLane - used to set the lane for the marker in the overview ruler. If not specified, it will default to the right hand lane. Use one of "left", "center", "right", or "full". You can also use "none" to disable the ruler markers.

type - used to control how much is highlighted in the editor. Valid values are:

tag - highlights just the tag
text - highlights the tag and any text after the tag
tag-and-comment - highlights the comment characters (or the start of the match) and the tag
tag-and-subTag - as above, but allows the sub tag to be highlight too (with colours defined in custom highlights)
text-and-comment - highlights the comment characters (or the start of the match), the tag and the text after the tag
line - highlights the entire line containing the tag
whole-line - highlights the entire line containing the tag to the full width of the editor
capture-groups:n,m... - highlights capture groups from the regex, where 'n' is the index into the regex
none - disable highlightling in the document
hideFromTree - used to hide tags from the tree, but still highlight in files

hideFromStatusBar - prevents the tag from being included in the status bar counts

hideFromActivityBar - prevents the tag from being included in the activity bar badge count

Example:

"todo-tree.highlights.defaultHighlight": {
"icon": "alert",
"type": "text",
"foreground": "red",
"background": "white",
"opacity": 50,
"iconColour": "blue"
},
"todo-tree.highlights.customHighlight": {
"TODO": {
"icon": "check",
"type": "line"
},
"FIXME": {
"foreground": "black",
"iconColour": "yellow",
"gutterIcon": true
}
}

Note: The highlight configuration is separate from the settings for the search. Adding settings in customHighlight does not automatically add the tags into todo-tree.general.tags.

\*Note: Using the capture-groups setting in type may have an impact on performance with large files.

Installing
You can install the latest version of the extension via the Visual Studio Marketplace here.

Alternatively, open Visual Studio code, press Ctrl+P or Cmd+P and type:

ext install Gruntfuggly.todo-tree

Source Code
The source code is available on GitHub here.

Controls
The tree view header can contain the following buttons:

collapse - Collapse all tree nodes
expand - Expand all tree nodes
flat - Show the tree view as a flat list, with the full filename for each TODO
tags - Show the view as a list of tags
tree - Show the tree view as a tree with expandable nodes for each folder (default)
tag - Group the TODOs in the tree by the tag
notag - Organise the TODOs by file (default)
filter - Only show items in the tree which match the entered filter text
clear-filter - Remove any active filter
refresh - Rebuild the tree
scan-open-files - Show tags from open files only
scan-current-file - Show tags from the current file
scan-workspace - Show tags from workspace only
scan-workspace - Show tags from workspace and open files
reveal - Show the current file in the tree
export - Export the tree content to a file

Folder Filter Context Menu
Right clicking in the tree view will bring up a context menu with the following options:

Hide This Folder/Hide This File - removes the folder or file from the tree
Only Show This Folder - remove all other folders and subfolders from the tree
Only Show This Folder And Subfolders - remove other folders from the tree, but keep subfolders
Reset Folder Filter - reset any folders previously filtered using the above
Toggle Badges - enable/disable SCM decorations
Toggle Compact Folders - enable/disable compressed folder names
Toggle Item Counts - enable/disable counts of tags
Scan Open Files Only - show TODOs from files open in VSCode (no search)
Scan Current File Only - show TODOs from the current open file only
Scan Workspace And Open Files - show TODOs from the workspace and any open files
Scan Workspace Only - show TODOs from the workspace only (requires manual refresh)
Expand Tree/Collapse Tree - expand or collapse the whole tree Show Tree View/Show Flat View/Show Tags Only View - change the tree view style Group by Tag/Ungroup by Tag - toggle grouping of items by tag Group by Sub Tag/Ungroup by Sub Tag - toggle grouping of items by sub tag Export Tree - dump the tree contents into a file Reveal Current File in Tree - show the current editor file in tree (if present)

Note: The current filters are shown in the debug log. Also, the filter can always be reset by right clicking the Nothing Found item in the tree. If your tree becomes invisible because everything is filtered and hideTreeWhenEmpty is set to true, you can reset the filter by pressing F1 and selecting the Todo Tree: Reset Folder Filter command.

Commands
Tags
To make it easier to configure the tags, there are two commands available:

Todo Tree: Add Tag - allows entry of a new tag for searching

Todo Tree: Remove Tag - shows a list of current tags which can be selected for removing

Note: The Remove Tag command can be used to show current tags - just press Escape or Enter with out selecting any to close it.

Export
The contents of the tree can be exported using Todo Tree: Export Tree. A read-only file will be created using the path specified with todo-tree.general.exportPath. The file can be saved using File: Save As.... Note: Currently File: Save does not work which seems to be a VSCode bug (see https://github.com/microsoft/vscode/issues/101952).

Switch Scope
Todo Tree: Switch Scope - shows a list of configured scopes which can be selected

Navigation
The commands Todo Tree: Go To Next and Todo Tree: Go To Previous can be used to move to the next and previous TODO within the current editor.

Configuration
The extension can be customised as follows (default values in brackets):

todo-tree.general.debug (false)
Show a debug channel in the output view.

todo-tree.general.periodicRefreshInteval (0)
Interval (in minutes) for automatically refreshing the tree. Set to '0' to disable, or to the number of minutes between refreshes. Note: This is not typically needed as the tree will be refreshed when files change.

todo-tree.general.automaticGitRefreshInterval (0)
Polling interval (in seconds) for automatically refreshing the tree when your repository is updated. This will check if your repository HEAD has changed and trigger a rescan of the workspace if it has. This replaces the file watcher functionality. Set to '0' to disable, or to the number of seconds between checks.

todo-tree.general.exportPath (~/todo-tree-%Y%m%d-%H%M.txt)
Path to use when exporting the tree. Environment variables will be expanded, e.g ${HOME} and the path is passed through strftime (see https://github.com/samsonjs/strftime). Set the extension to .json to export as a JSON record.

todo-tree.general.rootFolder ("")
By default, any open workspaces will have a tree in the view. Use this to force another folder to be the root of the tree. You can include environment variables and also use ${workspaceFolder}. e.g.
"todo-tree.general.rootFolder": "${workspaceFolder}/test"
or
"todo-tree.general.rootFolder": "${HOME}/project".

Note: Other open files (outside of the rootFolder) will be shown (as they are opened) with their full path in brackets.

todo-tree.general.schemes (['file','ssh','untitled'])
Editor schemes to find TODOs in. To find TODOs in settings files, for instance, add vscode-userdata or for output windows, add output.

todo-tree.general.tags (["TODO","FIXME","BUG"])
This defines the tags which are recognised as TODOs. This list is automatically inserted into the regex.

todo-tree.general.tagGroups ({})
This setting allows multiple tags to be treated as a single group. Example:

    "todo-tree.general.tagGroups": {
        "FIXME": [
            "FIXME",
            "FIXIT",
            "FIX",
        ]
    },

This treats any of FIXME, FIXIT or FIX as FIXME. When the tree is grouped by tag, all of these will appear under the FIXME node. This also means that custom highlights are applied to the group, not each tag type.

Note: all tags in the group should also appear in todo-tree.general.tags.

todo-tree.general.revealBehaviour (start of todo)
Change the cursor behaviour when clicking a todo in the tree. You can choose from: start of todo (moves the cursor to the beginning of the todo), end of todo (moves the cursor to the end of the todo), start of line (moves the cursor to the start of the line) or leave focus in tree which leaves the focus in the tree, allowing keyboard navigation of the tree.

todo-tree.general.statusBar (none)
What to show in the status bar - nothing (none), total count (total), counts per tag (tags), counts for the top three tags (top three) or counts for the current file only (current file).

todo-tree.general.statusBarClickBehaviour (reveal)
Set the behaviour of clicking the status bar to either cycle through the status bar display formats (cycle), reveal the tree (reveal) or to toggle highlights (toggle highlights).

todo-tree.general.showIconsInsteadOfTagsInStatusBar (false)
Show icons instead of tags in the status bar.

todo-tree.general.showActivityBarBadge (false)
Show a badge in the activity bar indicating the total number of found TODOs.

Note: When the tree view is in the Explorer pane, the badge is displayed on the Explorer icon, which may not be desirable.

todo-tree.filtering.includeGlobs ([])
Globs for use in limiting search results by inclusion, e.g. [\"**/unit-tests/*.js\"] to only show .js files in unit-tests subfolders. Globs help.

Note: globs paths are absolute - not relative to the current workspace.

todo-tree.filtering.excludeGlobs (["**/node_modules/*/**"])
Globs for use in limiting search results by exclusion (applied after includeGlobs), e.g. [\"**/*.txt\"] to ignore all .txt files.

Note: node_modules are excluded by default.

todo-tree.filtering.includedWorkspaces ([])
A list of workspace names to include as roots in the tree (wildcards can be used). An empty array includes all workspace folders.

todo-tree.filtering.excludedWorkspaces ([])
A list of workspace names to exclude as roots in the tree (wildcards can be used).

todo-tree.filtering.passGlobsToRipgrep (true)
Set this to false to apply the globs after the search (legacy behaviour).

todo-tree.filtering.useBuiltInExcludes (none)
Set this to use VSCode's built in files or search excludes. Can be one of none, file excludes (uses Files:Exclude), search excludes (Uses Search:Exclude) or file and search excludes (uses both).

todo-tree.filtering.ignoreGitSubmodules (false)
If true, any subfolders containing a .git file will be ignored when searching.

todo-tree.filtering.includeHiddenFiles (false)
If true, files starting with a period (.) will be included.

todo-tree.highlights.enabled (true)
Set this to false to turn off highlighting.

todo-tree.highlights.highlightDelay (500)
The delay before highlighting (milliseconds).

todo-tree.highlights.defaultHighlight ({})
Set default highlights. Example:

{
"foreground": "white",
"background": "red",
"icon": "check",
"type": "text"
}

todo-tree.highlights.customHighlight ({})
Set highlights per tag (or tag group). Example:

{
"TODO": {
"foreground": "white",
"type": "text"
},
"FIXME": {
"icon": "beaker"
}
}

todo-tree.highlights.useColourScheme (false)
Use a simple scheme for colouring highlights. This will simply apply a list of colours in the same order as the tags are defined. Use this as a much simpler alternative to setting up custom highlights for each tag.

Note: The colour scheme overrides the colours defined in todo-tree.highlights.defaultHighlight but not todo-tree.highlights.customHighlight.

todo-tree.highlights.backgroundColourScheme (["red","orange","yellow","green","blue","indigo","violet"])
Defines colours for use in conjunction with todo-tree.highlights.useColourScheme to colour highlights. Colours can be defined in the same way as other colours (e.g. hex code, theme names, etc.). If there are more tags than colours, the sequence is repeated.

todo-tree.highlights.foreroundColourScheme (["white","black","black","white","white","white","black"])
Defines colours for use in conjunction with todo-tree.highlights.backgroundColourScheme to colour highlights. These colours should be complementary to the background colours.

todo-tree.regex.enableMultiLine (false)
Normally, multiline support is enabled by detecting the use of \n in the regex. Set this to true, to enable multiline support by default. This allows the use of [\s\S] as an alternative to matching any character including newlines.

todo-tree.regex.regex ( (//|#|<!--|;|/\\_|^|^[ \\t]_(-|\\d+.))\\s\*($TAGS))

This defines the regex used to locate TODOs. By default, it searches for tags in comments starting with //, #, ;, <!-- or /\*, and also markdown todo lists. This should cover most languages. However if you want to refine it, make sure that the ($TAGS) is kept as ($TAGS) will be replaced by the expanded tag list. For some of the extension features to work, ($TAGS) should be present in the regex, however, the basic functionality should still work if you need to explicitly expand the tag list.

Note: This is a Rust regular expression, not javascript.

todo-tree.regex.subTagRegex This is a regular expression for processing the text to the right of the tag, e.g. for extracting a sub tag, or removing unwanted characters. Anything that the regex matches will be removed from the text. If a capture group is included, the contents are extracted into a sub tag, which will be used in the tree to group similar tags. The sub tag can also be used as a placeholder in todo-tree.tree.subTagClickUrl and todo-tree.tree.labelFormat. Sub tags can also be highlighted by specifying a section in the todo-tree.highlights.customHighlights setting. To highlight the sub tag itself, set "type" to "tag-and-subTag" in custom highlights for the tag.

Examples:

"^:\s\*" can be used to remove colons from immediately after tags.

"^\s*\((.*)\)" can be used to extract anything in parentheses after the tag and use it as a sub tag.

todo-tree.regex.regexCaseSensitive (true)
Set to false to allow tags to be matched regardless of case.

todo-tree.ripgrep.ripgrep ("")
Normally, the extension will locate ripgrep itself as and when required. If you want to use an alternate version of ripgrep, set this to point to wherever it is installed.

todo-tree.ripgrep.ripgrepArgs ("--max-columns=1000")
Use this to pass additional arguments to ripgrep. e.g. "-i" to make the search case insensitive. Use with caution!

todo-tree.ripgrep.ripgrepMaxBuffer (200)
By default, the ripgrep process will have a buffer of 200KB. However, this is sometimes not enough for all the tags you might want to see. This setting can be used to increase the buffer size accordingly.

todo-tree.ripgrep.usePatternFile (true)
A pattern file is used with ripgrep by default. If you experience issues with deleting the pattern file, set this to false to use the legacy method of providing the regex to ripgrep.

todo-tree.tree.hideTreeWhenEmpty (true)
Normally, the tree is removed from the explorer view if nothing is found. Set this to false to keep the view present.

todo-tree.tree.filterCaseSensitive (false)
Use this if you need the filtering to be case sensitive.

Note: this does not the apply to the search.

todo-tree.tree.trackFile (true)
Set to false if you want to prevent tracking the open file in the tree view.

todo-tree.tree.showBadges (true)
Set to false to disable SCM status and badges in the tree. \*

Note: This also unfortunately turns off themed icons.

todo-tree.tree.expanded\* (false)
Set to true if you want new views to be expanded by default.

todo-tree.tree.flat\* (false)
Set to true if you want new views to be flat by default.

todo-tree.tree.grouped\* (false)
Set to true if you want new views to be grouped by default.

todo-tree.tree.tagsOnly\* (false)
Set to true if you want new views with tags only by default.

todo-tree.tree.sortTagsOnlyViewAlphabetically (false)
Sort items in the tags only view alphabetically instead of in order of the tags list.

todo-tree.tree.showCountsInTree (false)
Set to true to show counts of TODOs in the tree.

todo-tree.tree.labelFormat (${tag} ${after})
Format of the TODO item labels. Available placeholders are ${line}, ${column}, ${tag}, ${before} (text from before the tag), ${after} (text from after the tag), ${filename}, ${filepath} and ${afterOrBefore} (use "after" text or "before" text if after is empty). When using ${tag} or ${subTag} you can also transform the text with "uppercase", "lowercase" or "capitalize", e.g. ${tag:lowercase}.

todo-tree.tree.scanMode (workspace)
By default the extension scans the whole workspace (workspace). Use this to limit the search to only open files (open files) or only the current file (current file).

todo-tree.tree.showScanModeButton (false)
Show a button on the tree view header to switch the scanMode (see above).

todo-tree.tree.hideIconsWhenGroupedByTag (false)
Hide item icons when grouping by tag.

todo-tree.tree.sort (true)
ripgrep searches using multiple threads to improve performance. The tree is sorted when it is populated so that it stays stable. If you want to use ripgrep's own sort arguments, set this to false.

Note: Depending on what scan mode you select, you may also want to disable auto-refresh when disabling the sort, otherwise the tree may still be unstable.

todo-tree.tree.disableCompactFolders (false)
The tree will normally respect the VSCode's explorer.compactFolders setting. Set this to true if you want to disable compact folders in the todo tree.

todo-tree.tree.tooltipFormat (${filepath}, ${line})
Format of the tree item tooltips. Uses the same placeholders as todo-tree.tree.labelFormat (see above).

todo-tree.tree.subTagClickUrl
A URL (which can contain placeholders), which will be opened when clicking on a sub tag in the tree, e.g. https://github.com/${subTag} could be used if the sub tag extracts a user name.

todo-tree.tree.buttons.reveal (true)
Show a button in the tree view title bar to reveal the current item (only when track file is not enabled).

todo-tree.tree.buttons.scanMode (false)
Show a button in the tree view title bar to change the Scan Mode setting.

todo-tree.tree.buttons.viewStyle (true)
Show a button in the tree view title bar to change the view style (tree, flat or tags only).

todo-tree.tree.buttons.groupByTag (true)
Show a button in the tree view title bar to enable grouping items by tag.

todo-tree.tree.buttons.groupBySubTag (false)
Show a button in the tree view title bar to enable grouping items by sub tag.

Note: This button will only be visible when sub tags have been found and are present in the tree.

todo-tree.tree.buttons.filter (true)
Show a button in the tree view title bar allowing the tree to be filtered by entering some text.

todo-tree.tree.buttons.refresh (true)
Show a refresh button in the tree view title bar.

todo-tree.tree.buttons.expand (true)
Show a button in the tree view title bar to expand or collapse the whole tree.

todo-tree.tree.buttons.export (false)
Show a button in the tree view title bar to create a text file showing the tree content.

\*Only applies to new workspaces. Once the view has been changed in the workspace, the current state is stored.

todo-tree.filtering.scopes ({})
Defines a set of file scopes that can be quickly switched between using the todo-tree.switchScope command.

This is a complex configuration property that can only be configured through the configuration JSON file. For example

"todo-tree.scopes": [
{
"name": "Production ",
"excludeGlobs": [
"**/tests/**"
]
},
{
"name": "Tests",
"includeGlobs": [
"**/tests/**"
]
},
{
"name": "All"
}
]

Multiline TODOs
If the regex contains \n, then multiline TODOs will be enabled. In this mode, the search results are processed slightly differently. If results are found which do not contain any tags from todo-tree.general.tags it will be assumed that they belong to the previous result that did have a tag. For example, if you set the regex to something like:

"todo-tree.regex.regex": "(//)\\s*($TAGS).*(\\n\\s*//\\s{2,}.*)\*"

This will now match multiline TODOs where the extra lines have at least two spaces between the comment characters and the TODO item. e.g.

// TODO multiline example
// second line
// third line

If you want to match multiline TODOs in C++ style multiline comment blocks, you'll need something like:

"todo-tree.regex.regex": "(/\\_)\\s_($TAGS)._(\\n\\s_(//|/\\_|\\_\\_)\\s{2,}._)\*"

which should match:

/_ TODO multiline example
** second line
** third line
_/

Note: If you are modifying settings using the settings GUI, you don't need to escape each backslash.

Warning: Multiline TODOs will not work with markdown TODOs and may have other unexpected results. There may also be a reduction in performance.

Excluding files and folders
To restrict the set of folders which is searched, you can define todo-tree.filtering.includeGlobs. This is an array of globs which the search results are matched against. If the results match any of the globs, they will be shown. By default the array is empty, which matches everything. See here for more information on globs.

Note: globs paths are absolute - not relative to the current workspace.

To exclude folders/files from your search you can define todo-tree.filtering.excludeGlobs. If the search results match any of these globs, then the results will be ignored.

You can also include and exclude folders from the tree using the context menu. This folder filter is applied separately to the include/exclude globs.

Note: By default, ripgrep ignores files and folders from your .gitignore or .ignore files. If you want to include these files, set todo-tree.ripgrep.ripgrepArgs to --no-ignore.

Markdown Support
When the extension was first written, very basic markdown support was added simply by adding a pattern to the default regex to match "- [ ]". A better way to handle markdown TODOs is to add "(-|\d+.)" to the list of "comments" in the first part of the regex and then adding "[ ]" and "[x]" to the list of tags in settings.json, e.g. :

"todo-tree.regex.regex": "(//|#|<!--|;|/\\_|^|^\\s_(-|\\d+.))\\s\*($TAGS)"
"todo-tree.general.tags": [
"BUG",
"HACK",
"FIXME",
"TODO",
"XXX",
"[ ]",
"[x]"
]

Note: If you modify the settings via the GUI, replace every instance of \\ in the regex setting with \.

This will then match all of the following:

- [ ] Do something
- [x] Something I've done

1. [ ] Do this first
2. [ ] Followed by this

This also allows custom highlighting to be applied, e.g.

"todo-tree.highlights.customHighlight": {
"[ ]": {
"background": "#ff000080"
},
"[x]": {
"background": "#00ff0080"
}
}

which will colour pending TODOs red and completed TODOs green.

Lastly, it will allow grouping by tag (and sub tags) to work and also work better when showing counts in the status bar.

Note: The default regex will be updated to reflect these changes at some point in the future.

Known Issues
Grouping by tag will only work when your configuration defines the tags using the todo-tree.general.tags setting. Older versions of the extension had the tags directly defined in the todo-tree.regex.regex whereas now, the regex replaces $TAGS with the contents of todo-tree.general.tags.

Grouping by tag doesn't work for markdown task list items as there is no tag to group with. The tree will show the files alongside the tag groups.

Tracking the file in the tree view when grouping by tag will reveal the first tag found.

When there is no current workspace, default icons will be shown in the tree.

Donate
If you find this extension useful, please feel free to donate here. Thanks!

Credits
Uses a modified version of ripgrep-js.

Main icons originally made by Freepik from www.flaticon.com is licensed by CC 3.0 BY

Tree view icons made by Vaadin from www.flaticon.com is licensed by CC 3.0 BY

Tag icons made by Dave Gandy from www.flaticon.com is licensed by CC 3.0 BY

Tags Icon made by Vectors Market from www.flaticon.com is licensed by CC 3.0 BY

Reveal Icon made by Gregor Cresnar from www.flaticon.com

Lots of the icons have now been updated by johnletey to match the new VS Code 1.37.0 GUI. Much appreciated!

Translations
Simplified Chinese translation by loniceras.

Runtime Status
Activation
Activated by onStartupFinished event: 21ms

Activation Events
onStartupFinished

Commands
ID Title Keyboard Shortcuts Menu Contexts
todo-tree.addTag

Add Tag

commandPalette

todo-tree.collapse

Collapse Tree

commandPalette view/item/context view/title

todo-tree.excludeThisFile

Hide This File

view/item/context

todo-tree.excludeThisFolder

Hide This Folder

view/item/context

todo-tree.expand

Expand Tree

commandPalette view/item/context view/title

todo-tree.exportTree

Export Tree

commandPalette view/item/context view/title

todo-tree.filter

Filter Tree

commandPalette view/item/context view/title

todo-tree.filterClear

Clear Tree Filter

commandPalette view/item/context view/title

todo-tree.goToNext

Go To Next

commandPalette

todo-tree.goToPrevious

Go To Previous

commandPalette

todo-tree.groupBySubTag

Group by Sub Tag

commandPalette view/item/context view/title

todo-tree.groupByTag

Group by Tag

commandPalette view/item/context view/title

todo-tree.refresh

Refresh

commandPalette view/title

todo-tree.removeFilter

Remove Filter

commandPalette view/item/context

todo-tree.removeTag

Remove Tag

commandPalette

todo-tree.resetAllFilters

Reset All Filters

commandPalette view/item/context

todo-tree.resetCache

Reset Cache

commandPalette

todo-tree.reveal

Reveal Current File In Tree

commandPalette view/item/context view/title

todo-tree.revealInFile

Reveal In File

commandPalette

todo-tree.scanCurrentFileOnly

Scan Current File Only

commandPalette view/item/context view/title

todo-tree.scanOpenFilesOnly

Scan Open Files Only

commandPalette view/item/context view/title

todo-tree.scanWorkspaceAndOpenFiles

Scan Workspace And Open Files

commandPalette view/item/context view/title

todo-tree.scanWorkspaceOnly

Scan Workspace Only

commandPalette view/item/context view/title

todo-tree.showFlatView

Show Flat View

commandPalette view/item/context view/title

todo-tree.showOnlyThisFolder

Only Show This Folder

view/item/context

todo-tree.showOnlyThisFolderAndSubfolders

Only Show This Folder And Subfolders

view/item/context

todo-tree.showTagsOnlyView

Show Tags Only View

commandPalette view/item/context view/title

todo-tree.showTreeView

Show Tree View

commandPalette view/item/context view/title

todo-tree.switchScope

Switch Scope

commandPalette

todo-tree.toggleBadges

Toggle Badges

commandPalette view/item/context

todo-tree.toggleCompactFolders

Toggle Compact Folders

commandPalette view/item/context

todo-tree.toggleItemCounts

Toggle Item Counts

commandPalette view/item/context

todo-tree.ungroupBySubTag

Ungroup by Sub Tag

commandPalette view/item/context view/title

todo-tree.ungroupByTag

Ungroup by Tag

commandPalette view/item/context view/title

Settings
ID Description Default
todo-tree.filtering.excludedWorkspaces

An array of workspace names to exclude as roots in the tree (wildcards can be used).

[]
todo-tree.filtering.excludeGlobs

Globs for use in limiting search results by exclusion (applied after includeGlobs), e.g. ["**/*.txt"] to ignore all .txt files.

[
"**/node_modules/*/**"
]
todo-tree.filtering.ignoreGitSubmodules

If true, any subfolders containing a .git file will be ignored when searching.

false
todo-tree.filtering.includedWorkspaces

An array of workspace names to include as roots in the tree (wildcards can be used). An empty array includes all workspace folders.

[]
todo-tree.filtering.includeGlobs

Globs for use in limiting search results by inclusion, e.g. ["**/unit-tests/*.js"] to only show .js files in unit-tests subfolders.

[]
todo-tree.filtering.includeHiddenFiles

Include hidden files (starting with a .).

false
todo-tree.filtering.passGlobsToRipgrep

By default the globs are passed into ripgrep to narrow the search. Set this to false to apply the globs after the search (pre 0.0.132 behaviour).

true
todo-tree.filtering.scopes

Scopes (sets of globs) that can be switched between

[]
todo-tree.filtering.useBuiltInExcludes

Add VSCode's files.exclude and/or search.exclude list to the ignored paths.

"none"
todo-tree.general.automaticGitRefreshInterval

Polling interval (in seconds) for automatically refreshing the tree when your repository is updated. Set to '0' to disable.

0
todo-tree.general.debug

Create a debug channel in the Output view.

false
todo-tree.general.exportPath

Path to use when exporting the tree. Environment variables will be expanded, e.g ${HOME} and the path is passed through strftime (see https://github.com/samsonjs/strftime). Set the extension to .json to export as a JSON record.

"~/todo-tree-%Y%m%d-%H%M.txt"
todo-tree.general.periodicRefreshInterval

Periodic refresh interval (in minutes) for automatically refreshing the tree. Set to '0' to disable.

0
todo-tree.general.revealBehaviour

Sets where the cursor is positioned when revealing a todo.

"start of todo"
todo-tree.general.rootFolder

Folder in which to run the search (defaults to the workspace folder).

""
todo-tree.general.schemes

Editor schemes to find TODOs in. To find TODOs in settings files, for instance, add vscode-userdata or for output windows, add output.

[
"file",
"ssh",
"untitled",
"vscode-notebook-cell"
]
todo-tree.general.showActivityBarBadge

Show a badge in the activity bar indicating the total number of TODOs

false
todo-tree.general.showIconsInsteadOfTagsInStatusBar

Show icons instead of tags in the status bar

false
todo-tree.general.statusBar

What to show in the status bar - nothing, total count, counts per tag, top three counts per tag or count of tags in the current file.

"none"
todo-tree.general.statusBarClickBehaviour

What to do when the status bar is clicked.

"reveal"
todo-tree.general.tagGroups

Allows similar tags to be grouped under the same type, e.g. { "FIX": ["FIXME","FIXIT"] }. Note: All tags must also be in the todo-tree.general.tags tag list. If a tag group is defined, custom highlights apply to the group, not the tags within the group.

{}
todo-tree.general.tags

List of tags. Note, if one tag starts with another tag, the longer tag should be specified first to prevent the shorter tag being matched.

[
"BUG",
"HACK",
"FIXME",
"TODO",
"XXX",
"[ ]",
"[x]"
]
todo-tree.highlights.backgroundColourScheme

A list of colours which is applied to tag highlights in the same order as the tags. Repeats if necessary and is overridden by todo-tree.highlights.customHighlight.

[
"red",
"orange",
"yellow",
"green",
"blue",
"indigo",
"violet"
]
todo-tree.highlights.customHighlight

Custom configuration for highlighting, Read more....

{
"BUG": {
"icon": "bug"
},
"HACK": {
"icon": "tools"
},
"FIXME": {
"icon": "flame"
},
"XXX": {
"icon": "x"
},
"[ ]": {
"icon": "issue-draft"
},
"[x]": {
"icon": "issue-closed"
}
}
todo-tree.highlights.defaultHighlight

Default configuration for highlighting. Read more....

{}
todo-tree.highlights.enabled

Set to false to disable highlighting.

true
todo-tree.highlights.foregroundColourScheme

A list of colours which is applied to tag highlights in the same order as the tags. Repeats if necessary and is overridden by todo-tree.highlights.customHighlight.

[
"white",
"black",
"black",
"white",
"white",
"white",
"black"
]
todo-tree.highlights.highlightDelay

Delay before highlighting tags within files (milliseconds).

500
todo-tree.highlights.useColourScheme

Use a colour scheme to colour the tags. This scheme is applied to the tags in the order of tags. The colours can be modified using todo-tree.highlights.foregroundColourScheme and todo-tree.highlights.backgroundColourScheme. The colour scheme overrides colours in the default highlight, but not the custom highlight.

false
todo-tree.regex.enableMultiLine

Force the regex to match over multiple lines. Allows use of [\s\S] to match anything including newlines.

false
todo-tree.regex.regex

Regular expression for matching TODOs. Note: ($TAGS) will be replaced by the expanded tag list. For some of the extension features to work, ($TAGS) should be present in the regex, however, the basic functionality should still work if you need to explicitly expand the tag list.

"(//|#|<!--|;|/\\_|^|^[ \\t]_(-|\\d+.))\\s\*($TAGS)"
todo-tree.regex.regexCaseSensitive

Use a case sensitive regular expression.

true
todo-tree.regex.subTagRegex

Regular expression for processing the text to the right of the tag, e.g. for extracting a sub tag, or removing unwanted characters.

""
todo-tree.ripgrep.ripgrep

Location of your version of ripgrep.

""
todo-tree.ripgrep.ripgrepArgs

Additional arguments to pass to ripgrep (Use with caution!).

"--max-columns=1000 --no-config "
todo-tree.ripgrep.ripgrepMaxBuffer

Size of the buffer to use for retrieving output from ripgrep (kilobytes).

200
todo-tree.ripgrep.usePatternFile

A pattern file is used with ripgrep by default. If you experience issues with deleting the pattern file, set this to false to use the legacy method of providing the regex to ripgrep.

true
todo-tree.tree.autoRefresh

Refresh the tree when files are opened or saved.

true
todo-tree.tree.buttons.expand

Show a button in the tree view title bar to expand or collapse the whole tree.

true
todo-tree.tree.buttons.export

Show a button in the tree view title bar to create a file showing the tree content.

false
todo-tree.tree.buttons.filter

Show a button in the tree view title bar allowing the tree to be filtered by entering some text.

true
todo-tree.tree.buttons.groupBySubTag

Show a button in the tree view title bar to enable grouping items by sub tag.

false
todo-tree.tree.buttons.groupByTag

Show a button in the tree view title bar to enable grouping items by tag.

true
todo-tree.tree.buttons.refresh

Show a refresh button in the tree view title bar.

true
todo-tree.tree.buttons.reveal

Show a button in the tree view title bar to reveal the current item (only when track file is not enabled).

true
todo-tree.tree.buttons.scanMode

Show a button in the tree view title bar to change the Scan Mode setting.

false
todo-tree.tree.buttons.viewStyle

Show a button in the tree view title bar to change the view style (tree, flat or tags only).

true
todo-tree.tree.disableCompactFolders

Prevent the tree from showing compact folders.

false
todo-tree.tree.expanded

When opening new workspaces, show the tree initially fully expanded.

false
todo-tree.tree.filterCaseSensitive

Set to true if you want the view filtering to be case sensitive.

false
todo-tree.tree.flat

When opening new workspaces, show the tree initially as flat list of files.

false
todo-tree.tree.groupedBySubTag

When opening new workspaces, show the tree initially grouped by sub tag.

false
todo-tree.tree.groupedByTag

When opening new workspaces, show the tree initially grouped by tag.

false
todo-tree.tree.hideIconsWhenGroupedByTag

Save some space by hiding the item icons when grouped by tag.

false
todo-tree.tree.hideTreeWhenEmpty

Hide the view if it is empty.

false
todo-tree.tree.labelFormat

Format for tree items.

"${tag} ${after}"
todo-tree.tree.scanAtStartup

Normally the tree is built as soon as the window is opened. If you have a large code base and want to manually start the scan, set this to false.

true
todo-tree.tree.scanMode

Set this to change which files are scanned.

"workspace"
todo-tree.tree.showBadges

Show badges and SCM state in the tree view.

true
todo-tree.tree.showCountsInTree

Show counts of TODOs in the tree.

false
todo-tree.tree.showCurrentScanMode

Show the current scan mode at the top of the tree view

true
todo-tree.tree.showInExplorer

false
todo-tree.tree.showScanOpenFilesOrWorkspaceButton

false
todo-tree.tree.showTagsFromOpenFilesOnly

false
todo-tree.tree.sort

ripgrep searches using multiple threads to improve performance. The tree is sorted when it is populated so that it stays stable. If you want to use ripgrep's own sort arguments, set this to false.

true
todo-tree.tree.sortTagsOnlyViewAlphabetically

Sort items in the tags only view alphabetically instead of by file and line number.

false
todo-tree.tree.subTagClickUrl

The URL to open when clicking on a sub tag in the tree. Can include placeholders as defined in todo-tree.tree.labelFormat.

""
todo-tree.tree.tagsOnly

When opening new workspaces, show only tag elements in tree.

false
todo-tree.tree.tooltipFormat

Tree item tooltip format.

"${filepath}, line ${line}"
todo-tree.tree.trackFile

Track the current file in the tree view.

true

View Containers
ID Title Where
todo-tree-container

TODOs

activitybar

Views
ID Name Where
todo-tree-view

TODOs

todo-tree-container
