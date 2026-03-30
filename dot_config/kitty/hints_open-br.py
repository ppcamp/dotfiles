# from kittens.tui.loop import debug
# debug('whatever')

import re
from pathlib import Path

def mark(text, args, Mark, extra_cli_args, *a):
    # This function is responsible for finding all
    # matching text. extra_cli_args are any extra arguments
    # passed on the command line when invoking the kitten.
    # We mark all individual word for potential selection
    for idx, m in enumerate(re.finditer(r'pull request #(\d+)', text)):
        start, end = m.span()
        mark_text = text[start:end].replace('\n', '').replace('\0', '')

        display_text = m.group(0)
        pr=m.group(1)

        yield Mark(idx, start, end, mark_text, {'pr':pr})


def main(args: list[str]) -> str:
    # this is the main entry point of the kitten, it will be executed in
    # the overlay window when the kitten is launched

    answer = input('Enter some text: ')
    project=(answer or "").strip()
    # whatever this function returns will be available in the
    # handle_result() function
    return answer

def handle_result(args, data, target_window_id, boss, extra_cli_args, *a):
    # This function is responsible for performing some
    # action on the selected text.
    # matches is a list of the selected entries and groupdicts contains
    # the arbitrary data associated with each entry in mark() above

    project = ""
    folder = Path(data.get('cwd')).name

    matches, groupdicts = [], []
    for m, g in zip(data['match'], data['groupdicts']):
        if m:
            matches.append(m), groupdicts.append(g)
    for word, match_data in zip(matches, groupdicts):
        # Lookup the word in a dictionary, the open_url function
        # will open the provided url in the system browser
        url = f"https://bitbucket.org/{project}/{folder}/pull-requests/{match_data['pr']}"
        boss.open_url(url)

