module ApplicationHelper
  def default_meta_tags
    {
      site: 'Poembox',
      title: 'Poembox',
      reverse: true,
      charset: 'utf-8',
      description: 'Post Poem With Emotional Image',
      keywords: 'poem,photo,image',
      canonical: request.original_url,
      separator: '|',
      viewport: 'width=device-width, initial-scale=1',
      icon: { href: image_url('/favicon.ico') },
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: { href: image_url('ogp-image.jpg') },
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@poembox__',
      }
    }
  end
end
