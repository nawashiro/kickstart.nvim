const { parsers } = require('prettier/parser-markdown')

// CJK ranges based on Unicode blocks commonly used for Chinese, Japanese, and Korean text.
const CJK_CHAR_CLASS =
  '[\\u2e80-\\u2fff\\u3000-\\u303f\\u31c0-\\u31ef\\u3400-\\u4dbf\\u4e00-\\u9fff\\uf900-\\ufaff]'
const ASCII_VISIBLE_CLASS = '[!-~]'

const cjkToAscii = new RegExp(`(${CJK_CHAR_CLASS})(\\s*)(${ASCII_VISIBLE_CLASS})`, 'g')
const asciiToCjk = new RegExp(`(${ASCII_VISIBLE_CLASS})(\\s*)(${CJK_CHAR_CLASS})`, 'g')

function normalizeCjkAsciiSpacing(segment) {
  return segment.replace(cjkToAscii, '$1 $3').replace(asciiToCjk, '$1 $3')
}

function applySpacingOutsideInlineCode(line) {
  let result = ''
  let buffer = ''
  let inInlineCode = false

  for (let i = 0; i < line.length; i += 1) {
    const char = line[i]

    if (char === '`') {
      // Flush buffered text before toggling inline code state.
      result += inInlineCode ? buffer : normalizeCjkAsciiSpacing(buffer)
      buffer = ''

      // Capture runs of backticks as a single token.
      let run = 1
      while (i + run < line.length && line[i + run] === '`') {
        run += 1
      }

      result += '`'.repeat(run)
      i += run - 1
      inInlineCode = !inInlineCode
      continue
    }

    buffer += char
  }

  result += inInlineCode ? buffer : normalizeCjkAsciiSpacing(buffer)
  return result
}

function addSpacingOutsideCodeFences(text) {
  const lines = text.split('\n')
  let inFence = false
  let fenceMarker = ''

  const processed = lines.map((line) => {
    const fenceMatch = line.match(/^(\s*)(`{3,}|~{3,})/)
    if (fenceMatch) {
      const marker = fenceMatch[2][0]
      if (!inFence) {
        inFence = true
        fenceMarker = marker
      } else if (marker === fenceMarker) {
        inFence = false
        fenceMarker = ''
      }
      return line
    }

    if (inFence) {
      return line
    }

    return applySpacingOutsideInlineCode(line)
  })

  return processed.join('\n')
}

module.exports = {
  parsers: {
    markdown: {
      ...parsers.markdown,
      preprocess(text, options) {
        const base = parsers.markdown.preprocess
          ? parsers.markdown.preprocess(text, options)
          : text

        return addSpacingOutsideCodeFences(base)
      },
    },
  },
}
