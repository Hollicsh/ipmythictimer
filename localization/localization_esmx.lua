if GetLocale() ~= "esMX" then return end

local AddonName, Addon = ...

Addon.localization.ADDELEMENT = "Añadir elemento"

Addon.localization.BACKGROUND = "Fondo"
Addon.localization.BGCOLOR    = "Color de fondo"
Addon.localization.BORDER     = "Borde"
Addon.localization.BORDERLIST = "Selecciona un borde de la biblioteca"
Addon.localization.BOTTOM     = "Abajo"
Addon.localization.BRDERWIDTH = "Ancho del borde"

Addon.localization.CLEANDBBT  = "Limpiar BD"
Addon.localization.CLEANDBTT  = "Borra la base de datos interna del addon con el porcentaje de enemigos.\n" ..
                                "Útil si el contador de porcentaje está bugueado"
Addon.localization.CLOSE      = "Cerrar"
Addon.localization.COLOR      = "Color"
Addon.localization.COLORDESCR = {
    TIMER = {
        [-1] = 'Color del temporizador cuando la clave se agota',
        [0]  = 'Color del temporizador en rango de +1',
        [1]  = 'Color del temporizador en rango de +2',
        [2]  = 'Color del temporizador en rango de +3',
    },
    OBELISKS = {
        [-1] = 'Color del obelisco abierto',
        [0]  = 'Color del obelisco cerrado',
    },
}
Addon.localization.COPY       = "Copiar"
Addon.localization.CORRUPTED  = {
    [161124] = "Urg'roth, Verdugo de Héroes (Rompearmaduras)",
    [161241] = "Tejevacío Mal'thir (Araña)",
    [161243] = "Samh'rek, Clamador del Caos (Miedo)",
    [161244] = "Sangre del Corruptor (Babosa)",
}
Addon.localization.CURSEASON  = "Temporada actual"

Addon.localization.DAMAGE     = "Daño"
Addon.localization.DBCLEANED  = "Base de datos de porcentaje de enemigos limpiada"
Addon.localization.DECORELEMS = "Elementos decorativos"
Addon.localization.DEFAULT    = "Por defecto"
Addon.localization.DEATHCOUNT = "Muertes"
Addon.localization.DEATHSHOW  = "Haz clic para ver información detallada"
Addon.localization.DEATHTIME  = "Tiempo perdido"
Addon.localization.DELETDECOR = "Eliminar elemento decorativo"
Addon.localization.DIRECTION  = "Dirección del progreso"
Addon.localization.DIRECTIONS = {
    asc  = "Ascendente (0% -> 100%)",
    desc = "Descendente (100% -> 0%)",
}
Addon.localization.DTHCAPTION = "Historial de muertes"
Addon.localization.DEATHSHIDE = "Ocultar historial de muertes"
Addon.localization.DEATHSSHOW = "Mostrar historial de muertes"
Addon.localization.DTHCAPTFS  = "Tamaño de fuente del título"
Addon.localization.DTHHEADFS  = "Tamaño de fuente de cabeceras"
Addon.localization.DTHRCRDPFS = "Tamaño de fuente de filas"

Addon.localization.ELEMENT    = {
    AFFIXES   = "Afijos activos",
    BOSSES    = "Jefes",
    DEATHS    = "Muertes",
    DUNGENAME = "Nombre de la mazmorra",
    LEVEL     = "Nivel",
    OBELISKS  = "Obeliscos",
    PLUSLEVEL = "Mejora de clave",
    PLUSTIMER = "Tiempo hasta que la clave baja",
    PROGRESS  = "Enemigos eliminados",
    PROGNOSIS = "Porcentaje tras el pull",
    TIMER     = "Tiempo restante",
    TIMERBAR  = "Barra de tiempo",
    TORMENT   = "Tormentos",
}
Addon.localization.ELEMACTION =  {
    SHOW = "Mostrar elemento",
    HIDE = "Ocultar elemento",
    MOVE = "Mover elemento",
}
Addon.localization.ELEMPOS    = "Posición del elemento"

Addon.localization.FONT       = "Fuente"
Addon.localization.FONTSIZE   = "Tamaño de fuente"
Addon.localization.FONTSTYLE  = "Estilo de fuente"
Addon.localization.FONTSTYLES = {
    NORMAL  = "Normal",
    OUTLINE = "Contorno",
    MONO    = "Monocromo",
    THOUTLN = "Contorno grueso",
}
Addon.localization.FOOLAFX    = "Afijo extra"
Addon.localization.FOOLAFXDSC = "Parece que hay un afijo adicional en tu grupo... y resulta sospechosamente familiar"

Addon.localization.HEIGHT     = "Altura"
Addon.localization.HELP       = {
    AFFIXES    = "Afijos activos",
    BOSSES     = "Jefes derrotados",
    DEATHTIMER = "Tiempo perdido por muertes",
    LEVEL      = "Nivel de la clave",
    PLUSLEVEL  = "Siguiente nivel de clave",
    PLUSTIMER  = "Tiempo hasta que la clave baja",
    PROGNOSIS  = "Progreso tras eliminar el pull",
    PROGRESS   = "Enemigos eliminados",
    TIMER      = "Tiempo restante",
}
Addon.localization.HORIZONTAL = "Horizontal"

Addon.localization.ICONSIZE   = "Tamaño del icono"
Addon.localization.IMPORT     = "Importar"

Addon.localization.JUSTIFYH   = "Alineación horizontal del texto"
Addon.localization.JUSTIFYV   = "Alineación vertical del texto"

Addon.localization.KEYSNAME   = "Nombre de las claves"

Addon.localization.LAYER      = "Capa"
Addon.localization.LEFT       = "Izquierda"
Addon.localization.LIMITPRGRS = "Limitar progreso al 100%"

Addon.localization.MAPBUT     = "Clic izquierdo - alternar opciones\n" ..
                                "Arrastrar con clic izquierdo - mover botón"
Addon.localization.MAPBUTOPT  = "Mostrar/Ocultar botón del minimapa"
Addon.localization.MELEEATACK = "Ataque cuerpo a cuerpo"

Addon.localization.OK         = "Aceptar"
Addon.localization.OPTIONS    = "Opciones"
Addon.localization.ORIENT     = "Orientación"

Addon.localization.PADDING    = "Espaciado interno"
Addon.localization.POINT      = "Punto"
Addon.localization.PRECISEPOS = "Clic derecho para posicionamiento preciso"
Addon.localization.PROGFORMAT = {
    percent = "Porcentaje (100.00%)",
    forces  = "Fuerzas (300)",
}
Addon.localization.PROGRESS   = "Formato de progreso"

Addon.localization.RELPOINT   = "Punto relativo"
Addon.localization.RIGHT      = "Derecha"
Addon.localization.RNMKEYSBT  = "Renombrar claves"
Addon.localization.RNMKEYSTT  = "Aquí puedes cambiar el nombre de las claves en el temporizador"

Addon.localization.SCALE      = "Escala"
Addon.localization.SEASONOPTS = "Opciones de temporada"
Addon.localization.SHROUDED   = {
    [189878] = "Infiltrador Nathrezim",
    [190128] = "Zul'gamux",
}
Addon.localization.SOURCE     = "Fuente"
Addon.localization.STARTINFO  = "iP Mythic Timer cargado. Escribe /ipmt para ver las opciones."

Addon.localization.TEXTURE    = "Textura"
Addon.localization.TEXTURELST = "Selecciona una textura de la biblioteca"
Addon.localization.TXTCROP    = "Recortar textura"
Addon.localization.TXTRINDENT = "Sangrado de textura"
Addon.localization.TXTSETTING = "Configuración avanzada de textura"
Addon.localization.THEME      = "Tema"
Addon.localization.THEMEACTN  = {
    NEW    = "Crear nuevo tema",
    COPY   = "Duplicar tema actual",
    IMPORT = "Importar tema",
    EXPORT = "Exportar tema",
}
Addon.localization.THEMEBUTNS = {
    ACTIONS     = "Usar este tema",
    DELETE      = "Eliminar tema actual",
    RESTORE     = 'Restaurar tema "' .. Addon.localization.DEFAULT .. '" y seleccionarlo',
    OPENEDITOR  = "Abrir editor de temas",
    CLOSEEDITOR = "Cerrar editor de temas",
}
Addon.localization.THEMEDITOR = "Editar tema"
Addon.localization.THEMENAME  = "Nombre del tema"
Addon.localization.TIMERDIRS  = {
    desc = "Descendente (36:00 -> 0:00)",
    asc  = "Ascendente (0:00 -> 36:00)",
}
Addon.localization.TIMERDIR   = "Dirección del temporizador"
Addon.localization.TOP        = "Arriba"
Addon.localization.TORMENTED  = {
    [179891] = "Soggodon el Destructor (Cadenas)",
    [179890] = "Verdugo Varruth (Miedo)",
    [179892] = "Oros Corazón Helado (Hielo)",
    [179446] = "Incinerador Arkolath (Fuego)",
}
Addon.localization.TIME       = "Tiempo"
Addon.localization.TIMERCHCKP = "Puntos de control del temporizador"

Addon.localization.UNKNOWN    = "Desconocido"

Addon.localization.VERTICAL   = "Vertical"

Addon.localization.WAVEALERT  = "Avisar cada {percent}%"
Addon.localization.WIDTH      = "Ancho"
Addon.localization.WHATSNEW   = "¿Qué hay de nuevo?"
Addon.localization.WHODIED    = "Quién murió"