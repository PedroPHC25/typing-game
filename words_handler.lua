local utf8 = require("utf8")

-- Função para classificar as palavras de acordo com o tamanho
local function getLengthCategory(word)
    local len = utf8.len(word)

    if len <= 5 then
        return "le5"
    elseif len >= 6 and len <= 10 then
        return "le10"
    else
        return "gt10"
    end
end

-- Função para classificar as palavras de acordo com a presença de letras maiúsculas
local function getUppercaseCategory(word)
    for pos, code in utf8.codes(word) do
        local char = utf8.char(code)

        if char:upper() == char and char:lower() ~= char then
            return true
        end
    end

    return false
end

-- Função para classificar as palavras de acordo com a presença de acento
local function getAccentCategory(word)
    return utf8.len(word) ~= string.len(word)
end

-- Função para classificar as palavras de acordo com a presença de hífen
local function getHyphenCategory(word)
    return string.find(word, "-") ~= nil
end

-- Função para carregar as palavras do arquivo
function loadWords(filepath)
    -- Inicializando as 24 tabelas de forma estruturada
    local words = {}
    local length_categories = {"le5", "le10", "gt10"}
    local case_categories = {"no_upper", "has_upper"}
    local accent_categories = {"no_accent", "has_accent"}
    local hyphen_categories = {"no_hyphen", "has_hyphen"}

    -- Criando a estrutura aninhada para armazenar as palavras categorizadas
    for _, len_cat in ipairs(length_categories) do
        words[len_cat] = {}
        for _, case_cat in ipairs(case_categories) do
            words[len_cat][case_cat] = {}
            for _, accent_cat in ipairs(accent_categories) do
                words[len_cat][case_cat][accent_cat] = {}
                for _, hyphen_cat in ipairs(hyphen_categories) do
                    words[len_cat][case_cat][accent_cat][hyphen_cat] = {}
                end
            end
        end
    end

    local file = love.filesystem.newFile(filepath, "r")

    if file:isOpen() then
        local content = file:read()
        file:close()

        for line in content:gmatch("([^\r\n]+)") do
            line = line:gsub("^%s*(.-)%s*$", "%1")
            if #line > 0 then
                local len_cat = getLengthCategory(line)
                local case_cat = getUppercaseCategory(line) and "has_upper" or "no_upper"
                local accent_cat = getAccentCategory(line) and "has_accent" or "no_accent"
                local hyphen_cat = getHyphenCategory(line) and "has_hyphen" or "no_hyphen"
                table.insert(words[len_cat][case_cat][accent_cat][hyphen_cat], line)
            end
        end
    else
        print("Erro: Não foi possível abrir o arquivo de palavras: " .. filepath)
    end

    return words
end