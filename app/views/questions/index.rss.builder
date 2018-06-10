xml.instruct! :xml, version: "1.0"
xml.rss('version' => "2.0",
  'xmlns:opensearch' => "http://a9.com/-/spec/opensearch/1.1/",
  'xmlns:atom' => "http://www.w3.org/2005/Atom"){
  xml.channel{
    if @user
      xml.title t('question.user_question', login_name: @user.username)
      xml.link questions_url(user_id: @user.username)
    else
      xml.title t('question.library_group_question', library_group_name: @library_group.display_name.localize)
      xml.link questions_url
    end
    xml.description "Next-L Enju, an open source integrated library system developed by Project Next-L"
    xml.language @locale.to_s
    xml.ttl "60"
    if @user
      xml.tag! "atom:link", rel: 'self', href: questions_url(user_id: @user.username, format: :rss)
      xml.tag! "atom:link", rel: 'alternate', href: questions_url(user_id: @user.username)
    else
      xml.tag! "atom:link", rel: 'self', href: questions_url(format: :rss)
      xml.tag! "atom:link", rel: 'alternate', href: questions_url
    end
    #xml.tag! "atom:link", rel: 'search', :type => 'application/opensearchdescription+xml', href: page_opensearch_url(format: :xml)
    unless params[:query].blank?
      xml.tag! "opensearch:totalResults", @count[:query_result]
      xml.tag! "opensearch:startIndex", @questions.offset + 1
      xml.tag! "opensearch:itemsPerPage", @questions.per_page
      #xml.tag! "opensearch:Query", :role => 'request', :searchTerms => params[:query], :startPage => (params[:page] || 1)
    end
    @questions.each do |question|
      xml.item do
        xml.title question.body
        #xml.description(question.title)
        # rfc822
        xml.pubDate question.created_at.utc.rfc822
        xml.link question_url(question)
        xml.guid question_url(question), isPermaLink: "true"
      end
    end
  }
}
