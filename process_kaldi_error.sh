# cat data/noisy_dev/text | grep '^M'                         #???????????
# cat data/noisy_dev/text | tr -d '^M' >> text_noisy_dev          #??text??'^M'????text_test

# cat downloads/LibriSpeech/noisy-dev/3/31/3-31.trans.txt | grep '^M'

# ''''https://github.com/kaldi-asr/kaldi/issues/3702'''
# grep '3-31-0001 ' data/noisy_dev/text | uconv -f utf-8 -t utf-8 -x Any-Name
# output:
# \N{DIGIT THREE}\N{HYPHEN-MINUS}\N{DIGIT THREE}\N{DIGIT ONE}\N{HYPHEN-MINUS}\N{DIGIT ZERO}\N{DIGIT ZERO}\N{DIGIT ZERO}\N{DIGIT ONE}\N{SPACE}\N{LATIN SMALL LETTER L}\N{LATIN SMALL LETTER I}\N{SPACE}\N{LATIN SMALL LETTER B}\N{LATIN SMALL LETTER E}\N{SPACE}\N{LATIN SMALL LETTER E}\N{SPACE}\N{LATIN SMALL LETTER M}\N{LATIN SMALL LETTER I}\N{LATIN SMALL LETTER H}\N{SPACE}\N{LATIN SMALL LETTER K}\N{LATIN SMALL LETTER I}\N{LATIN SMALL LETTER A}\N{LATIN SMALL LETTER N}\N{LATIN SMALL LETTER N}\N{SPACE}\N{LATIN SMALL LETTER L}\N{LATIN SMALL LETTER A}\N{LATIN SMALL LETTER N}\N{SPACE}\N{LATIN SMALL LETTER L}\N{LATIN SMALL LETTER A}\N{LATIN SMALL LETTER N}\N{SPACE}\N{LATIN SMALL LETTER S}\N{LATIN SMALL LETTER A}\N{LATIN SMALL LETTER N}\N{SPACE}\N{LATIN SMALL LETTER S}\N{LATIN SMALL LETTER A}\N{LATIN SMALL LETTER N}\N{SPACE}\N{LATIN SMALL LETTER L}\N{LATIN SMALL LETTER O}\N{LATIN SMALL LETTER N}\N{LATIN SMALL LETTER G}\N{SPACE}\N{LATIN SMALL LETTER B}\N{LATIN SMALL LETTER E}\N{SPACE}\N{LATIN SMALL LETTER T}\N{LATIN SMALL LETTER S}\N{LATIN SMALL LETTER I}\N{LATIN SMALL LETTER A}\N{LATIN SMALL LETTER U}\N{SPACE}\N{LATIN SMALL LETTER T}\N{LATIN SMALL LETTER S}\N{LATIN SMALL LETTER N}\N{LATIN SMALL LETTER G}\N{<control-000D>}\N{<control-000A>}

cat data/noisy_dev/text | tr -d '/r' > data/noisy_dev/new_text