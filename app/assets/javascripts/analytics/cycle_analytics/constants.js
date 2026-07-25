import { __, s__ } from '~/locale';

export const OVERVIEW_STAGE_ID = 'overview';

export const DEFAULT_VALUE_STREAM = {
	id: 'default',
	slug: 'default',
	name: 'default'
};

export const NOT_ENOUGH_DATA_ERROR = s__(
	'valuestreamanalyticsstage|há 0 itens a serem mostrados nesse estágio, para esses filtros, neste time range.'
);

export const PAGINATION_TYPE = 'keyset';
export const PAGINATION_SORT_FIELD_END_EVENT = 'end_event';
export const PAGINATION_SORT_FIELD_DURATION = 'duration';
export const PAGINATION_SORT_DIRECTION_DESC = 'desc';
export const PAGINATION_SORT_DIRECTION_ASC = 'asc';
export const FIELD_KEY_TITLE = 'title';

export const I18N_VSA_ERROR_STAGES = __(
	'ocorreu um erro ao buscar os estágios de análise do fluxo de valor.'
);

export const I18N_VSA_ERROR_STAGE_MEDIAN = __(
	'ocorreu um erro ao obter os dados da mediana para os estágios.'
);

export const I18N_VSA_ERROR_SELECTED_STAGE = __(
	'ocorreu um erro ao buscar dados para o estágio selecionado.'
);

export const MILESTONES_ENDPOINT = '/-/milestones.json';
export const LABELS_ENDPOINT = '/-/labels.json';

export const MAX_LABELS = 100;
