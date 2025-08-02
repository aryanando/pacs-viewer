/** @type {AppTypes.Config} */
window.config = {
  routerBasename: null,
  extensions: [],
  modes: [],
  showStudyList: true,
  maxNumberOfWebWorkers: 3,
  showLoadingIndicator: true,
  showWarningMessageForCrossOrigin: true,
  showCPUFallbackMessage: true,
  strictZSpacingForVolumeViewport: true,
  // filterQueryParam: false,
  defaultDataSourceName: 'hasta-orthanc',
  dataSources: [
    {
      namespace: '@ohif/extension-default.dataSourcesModule.dicomweb',
      sourceName: 'hasta-orthanc',
      configuration: {
        friendlyName: 'Hasta Radiologi Orthanc Server',
        name: 'HastaOrthanc',
        wadoUriRoot: '/dicom-web/wado',
        qidoRoot: '/dicom-web',
        wadoRoot: '/dicom-web',
        qidoSupportsIncludeField: false,
        supportsReject: false,
        dicomUploadEnabled: true,
        imageRendering: 'wadors',
        thumbnailRendering: 'wadors',
        enableStudyLazyLoad: true,
        supportsFuzzyMatching: false,
        supportsWildcard: false,
        omitQuotationForMultipartRequest: true,
        bulkDataURI: {
          enabled: true,
          relativeResolution: 'studies',
        },
        // Custom headers for authentication if needed
        headers: {},
        // Request options
        requestOptions: {
          'Accept-Encoding': 'gzip, deflate, br',
          Accept: 'application/json, text/plain, */*',
        },
      },
    },
    {
      namespace: '@ohif/extension-default.dataSourcesModule.dicomjson',
      sourceName: 'dicomjson',
      configuration: {
        friendlyName: 'DICOM JSON',
        name: 'json',
      },
    },
    {
      namespace: '@ohif/extension-default.dataSourcesModule.dicomlocal',
      sourceName: 'dicomlocal',
      configuration: {
        friendlyName: 'DICOM Local',
      },
    },
  ],
  httpErrorHandler: error => {
    console.warn('DICOM HTTP Error:', error.status);

    // Custom error handling for common Orthanc issues
    if (error.status === 404) {
      console.warn('Study/Series not found in Orthanc');
    } else if (error.status === 500) {
      console.warn('Orthanc server error - check server logs');
    } else if (error.status === 0) {
      console.warn('Cannot connect to Orthanc - check if server is running on localhost:8042');
    }
  },

  // Custom hotkeys for Hasta Radiologi workflow
  hotkeys: [
    {
      commandName: 'incrementActiveViewport',
      label: 'Next Viewport',
      keys: ['right'],
    },
    {
      commandName: 'decrementActiveViewport',
      label: 'Previous Viewport',
      keys: ['left'],
    },
    {
      commandName: 'rotateViewportCW',
      label: 'Rotate Right',
      keys: ['r'],
    },
    {
      commandName: 'rotateViewportCCW',
      label: 'Rotate Left',
      keys: ['l'],
    },
    {
      commandName: 'invertViewport',
      label: 'Invert',
      keys: ['i'],
    },
    {
      commandName: 'flipViewportVertical',
      label: 'Flip Horizontally',
      keys: ['h'],
    },
    {
      commandName: 'flipViewportHorizontal',
      label: 'Flip Vertically',
      keys: ['v'],
    },
    {
      commandName: 'scaleUpViewport',
      label: 'Zoom In',
      keys: ['+'],
    },
    {
      commandName: 'scaleDownViewport',
      label: 'Zoom Out',
      keys: ['-'],
    },
    {
      commandName: 'fitViewportToWindow',
      label: 'Zoom to Fit',
      keys: ['='],
    },
    {
      commandName: 'resetViewport',
      label: 'Reset',
      keys: ['space'],
    },
    {
      commandName: 'nextImage',
      label: 'Next Image',
      keys: ['down'],
    },
    {
      commandName: 'previousImage',
      label: 'Previous Image',
      keys: ['up'],
    },
  ],

  // Study list configuration
  studyListFunctionsEnabled: true,

  // Experimental features
  experimental: {
    studyBrowserSort: true,
  },

  // UI customization for Hasta Radiologi
  whiteLabeling: {
    createLogoComponentFn: function (React) {
      return React.createElement(
        'div',
        {
          style: {
            color: '#fff',
            fontSize: '18px',
            fontWeight: 'bold',
            padding: '10px',
            display: 'flex',
            alignItems: 'center',
          },
        },
        [
          React.createElement(
            'span',
            {
              key: 'logo',
              style: { marginRight: '10px' },
            },
            '🏥'
          ),
          React.createElement(
            'span',
            {
              key: 'text',
            },
            'Hasta Radiologi PACS'
          ),
        ]
      );
    },
  },

  // Investigation mode dialog (disable for production)
  investigationalUseDialog: {
    option: 'never',
  },

  // Additional Orthanc-specific settings
  showDebugInformation: false,
  enableGoogleCloudAdapter: false,

  // Study prefetching for better performance
  studyPrefetchEnabled: true,

  // Default viewport settings
  defaultViewportSettings: {
    windowLevel: {
      width: 400,
      center: 40,
    },
  },
};
