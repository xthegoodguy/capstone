require 'wikipedia'
class Article < ApplicationRecord

  # HEADERS = headers: {
  #                                   "Accept" => "application/json"
  #                                   "Authorization" => "Token token=#{ ENV['NY_API_KEY'] }"
  #                         }
    belongs_to :user
    has_many :highlights

  def generatebib
    @biblio = []
    @biblio << author
    @biblio << article_title
    @biblio << publisher
    @biblio << date_published
    @biblio << medium
    @biblio << url
    @biblio.join(". ")
  end

  # def self.all
  #   articles = []
  #   response = Unirest.get(
  #                         "#{ ENV['CORE_HOST_NAME'] }/articles}"
  #                           ).body
  #   response.each do |top_stories_hash|
  #     articles << top_story = Article.new(
  #                                         article_title: top_stories_hash["title"],
  #                                         )
  #     #don't need a each loop, cause not calling into an array
  #   end
  #   articles
  # end

  def self.rand_articles
    wiki_articles = []
    articles = []
    2.times do
      wiki_articles << Wikipedia.find_random
    end

    wiki_articles.each do |wiki_article|
      article = Article.new(
                            article_title: wiki_article.title,
                            url: wiki_article.fullurl,
                            # publisher: "Wikimedia Foundation, Inc",
                            # medium: "Web",
                            # content: wiki_article.text,
                            image: wiki_article.main_image_url,
                            summary: wiki_article.summary
                            )
      articles << article
    end
    articles
  end

  # def self.all
  #   articles = user_articles
  #   articles
  # end

  # def self.create(title)
  #   wiki_article = Wikipedia.find(title)
  # end
  def self.edited_content(string)
    new_text = string.gsub(/(== ==|==)/, "<br />")
    p "NEW TEXT #{new_text}"
    new_text
  end

  def self.wiki_find(title)
    # title = title.gsub(/%/, ' ')
    # p title
    # reutrn json formated data need to mess with ruby code
    wiki_article = Wikipedia.find(title)

    wiki_content = edited_content(wiki_article.sanitized_content)
    article = Article.new(
                          article_title: wiki_article.title,
                          url: wiki_article.fullurl,
                          publisher: "Wikimedia Foundation, Inc",
                          medium: "Web",
                          content: wiki_content,
                          image: wiki_article.main_image_url,
                          summary: wiki_article.summary
                          )
    article
  end

  def self.chrome_find(title)
    wiki_article = Wikipedia.find(title)
    wiki_content = edited_content(wiki_article.sanitized_content)
    @article = Article.new(
                          user_id: 1,
                          article_title: wiki_article.title,
                          url: wiki_article.fullurl,
                          publisher: "Wikimedia Foundation, Inc",
                          medium: "Web",
                          content: wiki_content,
                          image: wiki_article.main_image_url,
                          summary: wiki_article.summary
                          )
  end

end
