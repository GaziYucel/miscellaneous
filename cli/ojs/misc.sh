exit

# checkout main

git -C ./ checkout main
git -C ./lib/pkp checkout main
git -C ./lib/ui-library checkout main
git -C ./plugins/blocks/browse checkout main
git -C ./plugins/blocks/makeSubmission checkout main
git -C ./plugins/generic/acron checkout main
git -C ./plugins/generic/citationStyleLanguage checkout main
git -C ./plugins/generic/credit checkout main
git -C ./plugins/generic/crossref checkout main
git -C ./plugins/generic/crossrefReferenceLinking checkout main
git -C ./plugins/generic/customBlockManager checkout main
git -C ./plugins/generic/googleAnalytics checkout main
git -C ./plugins/generic/googleScholar checkout main
git -C ./plugins/generic/jatsTemplate checkout main
git -C ./plugins/generic/jatsTemplate checkout main
git -C ./plugins/generic/lensGalley checkout main
git -C ./plugins/generic/openCitations checkout main
git -C ./plugins/generic/orcidProfile checkout main
git -C ./plugins/generic/pdfJsViewer checkout main
git -C ./plugins/generic/staticPages checkout main
git -C ./plugins/generic/tinymce checkout main
git -C ./plugins/generic/webFeed checkout main
git -C ./plugins/oaiMetadataFormats/oaiJats checkout main
git -C ./plugins/reports/counter/classes/COUNTER checkout main
git -C ./plugins/reports/reviewReport checkout main

git -C ./lib/pkp ./lib/counterBots checkout main
git -C ./lib/pkp ./lib/creditRoles checkout main

# unstage

git restore --staged ./
git restore --staged ./lib/pkp
git restore --staged ./lib/ui-library
git restore --staged ./plugins/blocks/browse
git restore --staged ./plugins/blocks/makeSubmission
git restore --staged ./plugins/generic/acron
git restore --staged ./plugins/generic/citationStyleLanguage
git restore --staged ./plugins/generic/credit
git restore --staged ./plugins/generic/crossref
git restore --staged ./plugins/generic/crossrefReferenceLinking
git restore --staged ./plugins/generic/customBlockManager
git restore --staged ./plugins/generic/googleAnalytics
git restore --staged ./plugins/generic/googleScholar
git restore --staged ./plugins/generic/jatsTemplate
git restore --staged ./plugins/generic/jatsTemplate
git restore --staged ./plugins/generic/lensGalley
git restore --staged ./plugins/generic/openCitations
git restore --staged ./plugins/generic/orcidProfile
git restore --staged ./plugins/generic/pdfJsViewer
git restore --staged ./plugins/generic/staticPages
git restore --staged ./plugins/generic/tinymce
git restore --staged ./plugins/generic/webFeed
git restore --staged ./plugins/oaiMetadataFormats/oaiJats
git restore --staged ./plugins/reports/counter/classes/COUNTER
git restore --staged ./plugins/reports/reviewReport

git -C ./lib/pkp restore --staged ./lib/counterBots
git -C ./lib/pkp restore --staged ./lib/creditRoles

# ignore submodule change

git update-index --assume-unchanged -- 
git update-index --assume-unchanged -- lib/pkp
git update-index --assume-unchanged -- lib/ui-library
git update-index --assume-unchanged -- plugins/blocks/browse
git update-index --assume-unchanged -- plugins/blocks/makeSubmission
git update-index --assume-unchanged -- plugins/generic/acron
git update-index --assume-unchanged -- plugins/generic/citationStyleLanguage
git update-index --assume-unchanged -- plugins/generic/credit
git update-index --assume-unchanged -- plugins/generic/crossref
git update-index --assume-unchanged -- plugins/generic/crossrefReferenceLinking
git update-index --assume-unchanged -- plugins/generic/customBlockManager
git update-index --assume-unchanged -- plugins/generic/googleAnalytics
git update-index --assume-unchanged -- plugins/generic/googleScholar
git update-index --assume-unchanged -- plugins/generic/jatsTemplate
git update-index --assume-unchanged -- plugins/generic/jatsTemplate
git update-index --assume-unchanged -- plugins/generic/lensGalley
git update-index --assume-unchanged -- plugins/generic/openCitations
git update-index --assume-unchanged -- plugins/generic/orcidProfile
git update-index --assume-unchanged -- plugins/generic/pdfJsViewer
git update-index --assume-unchanged -- plugins/generic/staticPages
git update-index --assume-unchanged -- plugins/generic/tinymce
git update-index --assume-unchanged -- plugins/generic/webFeed
git update-index --assume-unchanged -- plugins/oaiMetadataFormats/oaiJats
git update-index --assume-unchanged -- plugins/reports/counter/classes/COUNTER
git update-index --assume-unchanged -- plugins/reports/reviewReport

git -C ./lib/pkp update-index --assume-unchanged -- lib/counterBots
git -C ./lib/pkp update-index --assume-unchanged -- lib/creditRoles

# git status

git -C ./ status
git -C ./lib/pkp status
git -C ./lib/ui-library status
git -C ./plugins/blocks/browse status
git -C ./plugins/blocks/makeSubmission status
git -C ./plugins/generic/acron status
git -C ./plugins/generic/citationStyleLanguage status
git -C ./plugins/generic/credit status
git -C ./plugins/generic/crossref status
git -C ./plugins/generic/crossrefReferenceLinking status
git -C ./plugins/generic/customBlockManager status
git -C ./plugins/generic/googleAnalytics status
git -C ./plugins/generic/googleScholar status
git -C ./plugins/generic/jatsTemplate status
git -C ./plugins/generic/jatsTemplate status
git -C ./plugins/generic/lensGalley status
git -C ./plugins/generic/openCitations status
git -C ./plugins/generic/orcidProfile status
git -C ./plugins/generic/pdfJsViewer status
git -C ./plugins/generic/staticPages status
git -C ./plugins/generic/tinymce status
git -C ./plugins/generic/webFeed status
git -C ./plugins/oaiMetadataFormats/oaiJats status
git -C ./plugins/reports/counter/classes/COUNTER status
git -C ./plugins/reports/reviewReport status

git -C ./lib/pkp ./lib/counterBots status
git -C ./lib/pkp ./lib/creditRoles status
