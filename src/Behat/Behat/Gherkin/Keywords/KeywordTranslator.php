<?php

namespace Behat\Behat\Gherkin\Keywords;

use Behat\Gherkin\Keywords\KeywordsInterface;

/**
 * Keyword translator.
 */
class KeywordTranslator
{
    private $keywords = null;

    /**
     * Constructs translator.
     *
     * @param KeywordsInterface $keywords Keywords instance
     */
    public function __construct(KeywordsInterface $keywords)
    {
        $this->keywords = $keywords;
    }
    /**
     * Return step type When, Then, otherwise Given.
     *
     * @param string $type      The localized step type
     * @param string $language  Language name
     * @return string
     */
    public function transType($type, $language) {
        $this->keywords->setLanguage($language);
        if($this->in_keywords($type, $this->keywords->getWhenKeywords())) {
             $type = 'When';
        } elseif($this->in_keywords($type, $this->keywords->getThenKeywords())) {
             $type = 'Then';
        } else {
             $type = 'Given';
        }
        return $type;
    }

    private function in_keywords($type, $keywords) {
        $keywords = explode('|', $keywords);
        $keywords = array_map(function($keyword) {
            return str_replace('<', '', $keyword);
        }, $keywords);
        return in_array($type, $keywords);
    }

}
