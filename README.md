# ruby-chromedriver

Para especificações do Ruby 2.x, Chrome / [Chrome driver](https://sites.google.com/a/chromium.org/chromedriver/), 
Docker for [Capybara](https://github.com/teamcapybara/capybara)/[Cucumber](https://github.com/cucumber/cucumber) specs.


# CI/CD Configuration

Exemplo de configuração de CI do GitLab para o projeto Ruby usando imagem (http://git.cvc.com.br/help/ci/environments):

```yaml
image: 'vilariano128/image_web_test'

stages:
  - test
  - build
  - deploy

test:
  stage: test
  script:
    - echo "Test to staging server"
  only:
  - master
build:
  stage: build
  script:
    - echo "Build to staging server"
  only:
  - master

deploy:
  stage: deploy
  script:
    - echo "Deploy to staging server"
  only:
  - master

```

## License

This repo content is released under the [MIT License](http://www.opensource.org/licenses/MIT).

Copyright (c) 2017-2018 Nikita Bulai (agnaldo.s.vilariano@gmail.com).